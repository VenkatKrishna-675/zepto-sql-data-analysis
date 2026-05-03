# 🛒 Zepto SQL Data Analysis Project  

## 📌 Business Problem  
Zepto operates in a highly competitive quick-commerce market where pricing, discounts, and inventory directly impact revenue and customer satisfaction.  

This project aims to analyze product-level data to:  
- Identify revenue opportunities  
- Understand discount strategies  
- Detect inventory gaps (out-of-stock issues)  
- Evaluate product value for money  

---

## 🎯 Objective  
To transform raw Zepto dataset into actionable business insights using SQL by performing:  
- Data cleaning & preprocessing  
- Exploratory data analysis  
- Business-driven query solving  

---

## ⚙️ Tech Stack  
- 🛢️ MySQL (MySQL Workbench)  
- 🧠 SQL (Aggregation, Filtering, CASE, Data Cleaning)  

---

## 🗂️ Dataset Details  
The dataset contains product-level information including:  
- Product Name & Category  
- MRP (Original Price)  
- Discount Percentage  
- Discounted Selling Price  
- Available Quantity  
- Weight (grams)  
- Stock Availability  

---

## 🧹 Data Cleaning & Preparation  
- Removed products with invalid pricing (MRP = 0)  
- Converted price from paise to rupees  
- Fixed column encoding issue (`ï»¿category → category`)  
- Added Primary Key (`sku_id`)  
- Checked and handled null values  

---

## 🔍 Exploratory Data Analysis  
- Total number of products  
- Unique categories available  
- In-stock vs out-of-stock distribution  
- Duplicate product detection  

---

## 📊 Key Business Questions Solved  

### 1️⃣ Which products offer the highest discounts?  
Identified top products with maximum discount percentages.  

### 2️⃣ Which high-value products are out of stock?  
Helps in detecting lost sales opportunities.  

### 3️⃣ What is the estimated revenue per category?  
Calculated using:  
**Revenue = Price × Quantity**  

### 4️⃣ Which premium products have low discounts?  
Highlights premium pricing strategy.  

### 5️⃣ Which categories offer the highest average discounts?  
Useful for understanding category-level promotions.  

### 6️⃣ Which products provide best value for money?  
Analyzed using price per gram.  

### 7️⃣ Product segmentation based on weight  
Classified into Low, Medium, and Bulk categories.  

### 8️⃣ What is total inventory weight per category?  
Supports logistics and supply chain planning.  

---

## 📈 Key Insights  
- 📉 High discounts are concentrated in specific categories, indicating aggressive promotions  
- 💰 Premium products generally have lower discounts, reflecting pricing strategy  
- ⚠️ Several high-MRP products are out of stock, leading to potential revenue loss  
- ⚖️ Price-per-gram analysis reveals hidden value products for cost-conscious customers  
- 📦 Inventory distribution varies significantly across categories, impacting supply planning  

---

## 🔥 Sample SQL Queries  

```sql
-- Revenue estimation by category
SELECT category, 
       SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;

-- Best value products (price per gram)
SELECT name, weightInGms, discountedSellingPrice,
       ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;
