package com.WatchX.model;

public class ProductModel {
    private int productNo;
    private String productName;
    private String description;
    private String category;
    private String unitPrice;
    private String image_path;

    public ProductModel() {
    }

    public ProductModel(int productNo, String productName, String description, 
                       String category, String unitPrice, String image_path) {
        this.productNo = productNo;
        this.productName = productName;
        this.description = description;
        this.category = category;
        this.unitPrice = unitPrice;
        this.image_path = image_path;
    }

    // Getters and Setters
    public int getProductNo() {
        return productNo;
    }

    public void setProductNo(int productNo) {
        this.productNo = productNo;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(String unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getimage_path() {
        return image_path;
    }

    public void setimage_path(String image_path) {
        this.image_path = image_path;
    }

    @Override
    public String toString() {
        return "ProductModel{" +
                "productNo=" + productNo +
                ", productName='" + productName + '\'' +
                ", description='" + description + '\'' +
                ", category='" + category + '\'' +
                ", unitPrice='" + unitPrice + '\'' +
                ", image_path='" + image_path + '\'' +
                '}';
    }
}