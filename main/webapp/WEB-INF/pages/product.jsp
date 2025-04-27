<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Products Grid</title>
    <link rel="stylesheet" href="products.css">
    <style>
    /* Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Page Container */
.page-container {
    padding: 30px;
    background-color: #ecf0f1;
    min-height: 100vh;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* Top Bar */
.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.top-bar h2 {
    font-size: 28px;
    color: #2c3e50;
}

.top-actions .btn {
    margin-left: 10px;
}

/* Buttons */
.btn {
    padding: 10px 18px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: 500;
}

.export-btn {
    background-color: #3498db;
    color: white;
}

.create-btn {
    background-color: #2c3e50;
    color: white;
}

/* Filter Bar */
.filter-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.search-box {
    width: 300px;
    padding: 10px;
    border-radius: 8px;
    border: 1px solid #bdc3c7;
}

.filter-options select {
    padding: 10px;
    margin-left: 10px;
    border-radius: 8px;
    border: 1px solid #bdc3c7;
}

/* Product Grid */
.products-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 20px;
}

/* Product Card */
.product-card {
    background-color: white;
    border-radius: 10px;
    padding: 20px;
    text-align: center;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.product-card img {
    width: 120px;
    height: 120px;
    object-fit: contain;
    margin-bottom: 15px;
}

.product-card h4 {
    font-size: 18px;
    margin-bottom: 8px;
    color: #2c3e50;
}

.price {
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 12px;
    color: #2980b9;
}

.card-buttons {
    display: flex;
    justify-content: center;
    gap: 10px;
}

.edit-btn {
    background-color: #3498db;
    color: white;
}

.delete-btn {
    background-color: #e74c3c;
    color: white;
}

/* Pagination */
.pagination {
    display: flex;
    justify-content: center;
    margin-top: 30px;
    gap: 8px;
}

.page-btn {
    padding: 8px 14px;
    border: 1px solid #2c3e50;
    background-color: white;
    border-radius: 6px;
    cursor: pointer;
}

.page-btn.active {
    background-color: #2c3e50;
    color: white;
}
    
    </style>
</head>
<body>

    <div class="page-container">
        
        <!-- Top Bar -->
        <div class="top-bar">
            <h2>Products Grid</h2>
            <div class="top-actions">
                <button class="btn export-btn">Export</button>
                <button class="btn create-btn">+ Create New</button>
            </div>
        </div>

        <!-- Filters -->
        <div class="filter-bar">
            <input type="text" placeholder="Search..." class="search-box">
            <div class="filter-options">
                <select>
                    <option>Category</option>
                </select>
                <select>
                    <option>Last Added</option>
                </select>
            </div>
        </div>

        <!-- Product Grid -->
        <div class="products-grid">
            
            <!-- Single Product Card -->
            <div class="product-card">
                <img src="https://via.placeholder.com/120" alt="Product Image">
                <h4>T-shirt for Men</h4>
                <p class="price">$90.00</p>
                <div class="card-buttons">
                    <button class="btn edit-btn">Edit</button>
                    <button class="btn delete-btn">Delete</button>
                </div>
            </div>

            <!-- Duplicate this product card as needed -->
            <div class="product-card">
                <img src="https://via.placeholder.com/120" alt="Product Image">
                <h4>Travel Bag Jeans</h4>
                <p class="price">$19.50</p>
                <div class="card-buttons">
                    <button class="btn edit-btn">Edit</button>
                    <button class="btn delete-btn">Delete</button>
                </div>
            </div>

            <!-- More Product Cards... -->

        </div>

        <!-- Pagination -->
        <div class="pagination">
            <button class="page-btn">Previous</button>
            <button class="page-btn active">1</button>
            <button class="page-btn">2</button>
            <button class="page-btn">3</button>
            <button class="page-btn">Next</button>
        </div>

    </div>

</body>
</html>
