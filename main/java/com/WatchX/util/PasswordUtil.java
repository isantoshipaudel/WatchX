package com.WatchX.util;

import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

public class PasswordUtil {
    private static final String ENCRYPT_ALGO = "AES/GCM/NoPadding";
    private static final int TAG_LENGTH_BIT = 128; // must be one of {128, 120, 112, 104, 96}
    private static final int IV_LENGTH_BYTE = 12;
    private static final int SALT_LENGTH_BYTE = 16;
    private static final Charset UTF_8 = StandardCharsets.UTF_8;
    
    // Logger for the class
    private static final Logger LOGGER = Logger.getLogger(PasswordUtil.class.getName());
   
    /**
     * Generates a random nonce of specified bytes
     * @param numBytes Number of bytes for the nonce
     * @return Random byte array
     */
    public static byte[] getRandomNonce(int numBytes) {
        byte[] nonce = new byte[numBytes];
        new SecureRandom().nextBytes(nonce);
        return nonce;
    }

    /**
     * Generates an AES secret key of specified size
     * @param keysize Size of the key in bits (128, 192, or 256)
     * @return SecretKey
     * @throws NoSuchAlgorithmException
     */
    public static SecretKey getAESKey(int keysize) throws NoSuchAlgorithmException {
        KeyGenerator keyGen = KeyGenerator.getInstance("AES");
        keyGen.init(keysize, SecureRandom.getInstanceStrong());
        return keyGen.generateKey();
    }

    /**
     * Derives an AES 256-bit secret key from a password
     * @param password Password characters
     * @param salt Salt bytes
     * @return SecretKey
     */
    public static SecretKey getAESKeyFromPassword(char[] password, byte[] salt) {
        try {
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            // iterationCount = 65536
            // keyLength = 256
            KeySpec spec = new PBEKeySpec(password, salt, 65536, 256);
            SecretKey secret = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");
            return secret;
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            LOGGER.log(Level.SEVERE, "Error generating key from password", ex);
            return null;
        }
    }

    /**
     * Encrypts a password using username as the key source
     * @param username Username for key derivation
     * @param password Password to encrypt
     * @return Base64 encoded encrypted string or null if encryption fails
     */
    public static String encrypt(String username, String password) {
        try {
            // 16 bytes salt
            byte[] salt = getRandomNonce(SALT_LENGTH_BYTE);
            
            // GCM recommended 12 bytes iv
            byte[] iv = getRandomNonce(IV_LENGTH_BYTE);
            
            // secret key from username
            SecretKey aesKeyFromPassword = getAESKeyFromPassword(username.toCharArray(), salt);
            
            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
            
            // ASE-GCM needs GCMParameterSpec
            cipher.init(Cipher.ENCRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));
            
            byte[] cipherText = cipher.doFinal(password.getBytes(UTF_8));
            
            // prefix IV and Salt to cipher text
            byte[] cipherTextWithIvSalt = ByteBuffer.allocate(iv.length + salt.length + cipherText.length)
                    .put(iv)
                    .put(salt)
                    .put(cipherText)
                    .array();
            
            // string representation, base64, send this string to other for decryption.
            return Base64.getEncoder().encodeToString(cipherTextWithIvSalt);
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Error encrypting password", ex);
            return null;
        }
    }

    /**
     * Decrypts an encrypted password using username as the key source
     * @param encryptedPassword Base64 encoded encrypted password
     * @param username Username for key derivation
     * @return Decrypted password or null if decryption fails
     */
    public static String decrypt(String encryptedPassword, String username) {
        try {
            byte[] decode = Base64.getDecoder().decode(encryptedPassword.getBytes(UTF_8));
            
            // get back the iv and salt from the cipher text
            ByteBuffer bb = ByteBuffer.wrap(decode);
            
            byte[] iv = new byte[IV_LENGTH_BYTE];
            bb.get(iv);
            
            byte[] salt = new byte[SALT_LENGTH_BYTE];
            bb.get(salt);
            
            byte[] cipherText = new byte[bb.remaining()];
            bb.get(cipherText);
            
            // get back the aes key from the same username and salt
            SecretKey aesKeyFromPassword = getAESKeyFromPassword(username.toCharArray(), salt);
            
            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
            
            cipher.init(Cipher.DECRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));
            
            byte[] plainText = cipher.doFinal(cipherText);
            
            return new String(plainText, UTF_8);
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Error decrypting password", ex);
            return null;
        }
    }
    
    /**
     * Validates password strength
     * @param password Password to validate
     * @return true if password meets strength requirements, false otherwise
     */
    public static boolean isStrongPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        
        boolean hasUpperCase = false;
        boolean hasLowerCase = false;
        boolean hasDigit = false;
        boolean hasSpecialChar = false;
        
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) {
                hasUpperCase = true;
            } else if (Character.isLowerCase(c)) {
                hasLowerCase = true;
            } else if (Character.isDigit(c)) {
                hasDigit = true;
            } else if (!Character.isLetterOrDigit(c)) {
                hasSpecialChar = true;
            }
        }
        
        return hasUpperCase && hasLowerCase && hasDigit && hasSpecialChar;
    }
    
    /**
     * Validates a user's credentials
     * @param username Username to validate
     * @param password Password to validate
     * @param storedEncryptedPassword Stored encrypted password to compare against
     * @return true if credentials are valid, false otherwise
     */
    public static boolean validateCredentials(String username, String password, String storedEncryptedPassword) {
        if (username == null || password == null || storedEncryptedPassword == null) {
            return false;
        }
        
        String decryptedPassword = decrypt(storedEncryptedPassword, username);
        return decryptedPassword != null && decryptedPassword.equals(password);
    }
}