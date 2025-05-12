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
    private static final int TAG_LENGTH_BIT = 128;
    private static final int IV_LENGTH_BYTE = 12;
    private static final int SALT_LENGTH_BYTE = 16;
    private static final int KEY_LENGTH = 256;
    private static final int ITERATION_COUNT = 65536;
    private static final Charset UTF_8 = StandardCharsets.UTF_8;
    private static final Logger logger = Logger.getLogger(PasswordUtil.class.getName());

    public static byte[] getRandomNonce(int numBytes) {
        if (numBytes <= 0) {
            throw new IllegalArgumentException("Number of bytes must be positive");
        }
        byte[] nonce = new byte[numBytes];
        new SecureRandom().nextBytes(nonce);
        return nonce;
    }

    public static SecretKey getAESKey(int keysize) throws NoSuchAlgorithmException {
        if (keysize != 128 && keysize != 192 && keysize != 256) {
            throw new IllegalArgumentException("Invalid key size. Must be 128, 192 or 256");
        }
        KeyGenerator keyGen = KeyGenerator.getInstance("AES");
        keyGen.init(keysize, SecureRandom.getInstanceStrong());
        return keyGen.generateKey();
    }

    public static SecretKey getAESKeyFromPassword(char[] password, byte[] salt) {
        if (password == null || password.length == 0 || salt == null || salt.length == 0) {
            throw new IllegalArgumentException("Password and salt cannot be null or empty");
        }
        
        try {
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            KeySpec spec = new PBEKeySpec(password, salt, ITERATION_COUNT, KEY_LENGTH);
            return new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            logger.log(Level.SEVERE, "Error generating AES key from password", ex);
            throw new RuntimeException("Error generating AES key from password", ex);
        }
    }

    public static String encrypt(String username, String password) {
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            logger.warning("Invalid input parameters for encryption");
            return null;
        }

        try {
            byte[] salt = getRandomNonce(SALT_LENGTH_BYTE);
            byte[] iv = getRandomNonce(IV_LENGTH_BYTE);
            
            SecretKey aesKeyFromPassword = getAESKeyFromPassword(username.toCharArray(), salt);
            
            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
            cipher.init(Cipher.ENCRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));
            
            byte[] cipherText = cipher.doFinal(password.getBytes(UTF_8));
            
            byte[] cipherTextWithIvSalt = ByteBuffer.allocate(iv.length + salt.length + cipherText.length)
                    .put(iv)
                    .put(salt)
                    .put(cipherText)
                    .array();
            
            return Base64.getEncoder().encodeToString(cipherTextWithIvSalt);
        } catch (Exception ex) {
            logger.log(Level.SEVERE, "Encryption failed", ex);
            return null;
        }
    }

    public static String decrypt(String encryptedPassword, String username) {
        if (encryptedPassword == null || encryptedPassword.isEmpty() || 
            username == null || username.isEmpty()) {
            logger.warning("Invalid input parameters for decryption");
            return null;
        }

        try {
            byte[] decode = Base64.getDecoder().decode(encryptedPassword.getBytes(UTF_8));
            if (decode.length < IV_LENGTH_BYTE + SALT_LENGTH_BYTE) {
                logger.warning("Invalid encrypted password format");
                return null;
            }

            ByteBuffer bb = ByteBuffer.wrap(decode);
            
            byte[] iv = new byte[IV_LENGTH_BYTE];
            bb.get(iv);
            
            byte[] salt = new byte[SALT_LENGTH_BYTE];
            bb.get(salt);
            
            byte[] cipherText = new byte[bb.remaining()];
            bb.get(cipherText);
            
            SecretKey aesKeyFromPassword = getAESKeyFromPassword(username.toCharArray(), salt);
            
            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
            cipher.init(Cipher.DECRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));
            
            byte[] plainText = cipher.doFinal(cipherText);
            return new String(plainText, UTF_8);
        } catch (Exception ex) {
            logger.log(Level.SEVERE, "Decryption failed for username: " + username, ex);
            return null;
        }
    }

    public static boolean validateCredentials(String username, String password, String storedEncryptedPassword) {
        if (username == null || password == null || storedEncryptedPassword == null) {
            logger.warning("Validation failed: null parameters");
            return false;
        }
        
        String decryptedPassword = decrypt(storedEncryptedPassword, username);
        if (decryptedPassword == null) {
            logger.warning("Decryption returned null - invalid credentials or corrupted data");
            return false;
        }
        
        return decryptedPassword.equals(password);
    }
}