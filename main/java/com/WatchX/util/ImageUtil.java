
package com.WatchX.util;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;

public class ImageUtil {

    // Extracts image name from the uploaded part
    public String getImageNameFromPart(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String item : contentDisp.split(";")) {
            if (item.trim().startsWith("filename")) {
                String fileName = item.substring(item.indexOf('=') + 2, item.length() - 1);
                return fileName.isEmpty() ? "default.png" : fileName;
            }
        }
        return "default.png";
    }

    public boolean uploadImage(Part part, String rootPath, String saveFolder) {
		String savePath = getSavePath(saveFolder);
		File fileSaveDir = new File(savePath);

		// Ensure the directory exists
		if (!fileSaveDir.exists()) {
			if (!fileSaveDir.mkdir()) {
				return false; // Failed to create the directory
			}
		}
		try {
			// Get the image name
			String imageName = getImageNameFromPart(part);
			// Create the file path
			String filePath = savePath + "/" + imageName;
			// Write the file to the server
			part.write(filePath);
			return true; // Upload successful
		} catch (IOException e) {
			e.printStackTrace(); // Log the exception
			return false; // Upload failed
		}
	}

    // Returns absolute path for saving images
    public String getSavePath(String folderName) {
        return "C:/Users/sachida/eclipse-workspace/WatchX/src/main/webapp/resources/images/" + folderName;
    }

    // Generates a unique filename (e.g., UUID.png)
    public String generateUniqueFileName(Part part) {
        String extension = getFileExtension(getImageNameFromPart(part));
        return java.util.UUID.randomUUID().toString() + extension;
    }

    // Helper to extract file extension
    private String getFileExtension(String fileName) {
        int index = fileName.lastIndexOf(".");
        return (index > 0) ? fileName.substring(index) : ".png";
    }
}
