# 📦 Supply Chain & Inventory Health Dashboard

Real-time dashboard showing inventory health, supplier performance, and automated low-stock alerts.

## 🎯 Problem Solved
Small businesses struggle with stockouts and overstock due to siloed inventory, supplier, and sales data. This dashboard provides:
- Real-time inventory visibility
- Automated reorder recommendations
- Supplier performance tracking
- Daily Gmail alerts for low stock

## 📊 Dataset
- **Source:** [Global E-Commerce & Supply Chain Database (Kaggle)](https://www.kaggle.com/datasets/parsakh/global-e-commerce-and-supply-chain-database)
- **Files used:** inventory.csv, products.csv, transactions.csv, supplier_costs.csv
- **Size:** ~15 MB, 8 tables

## 🛠️ Tools Used (All Free)
- **BigQuery Sandbox:** Data warehouse & SQL transformations
- **Looker Studio:** Interactive dashboard
- **Google Sheets + Apps Script:** Automated email alerts
- **GitHub:** Code repository

## 📈 KPIs Calculated
1. **Stock Turnover:** Total sales ÷ Average inventory
2. **Days of Inventory (DSI):** Current stock ÷ Daily sales
3. **Fill Rate:** Orders shipped ÷ Orders received
4. **Supplier Lead Time Variance:** Reliability score by supplier

## 🚀 How to Deploy

### Step 1: Download Dataset
1. Go to [Kaggle dataset](https://www.kaggle.com/datasets/parsakh/global-e-commerce-and-supply-chain-database)
2. Download and unzip CSV files

### Step 2: Upload to BigQuery
1. Create BigQuery Sandbox project: [console.cloud.google.com/bigquery](https://console.cloud.google.com/bigquery)
2. Create dataset: `ecommerce_data`
3. Upload 4 CSVs as tables: products, inventory, transactions, supplier_costs

### Step 3: Create SQL Views
Run the SQL files in `/sql` folder in BigQuery:
- `view_dashboard_master.sql`
- `view_kpi_summary.sql`
- `view_supplier_scorecard.sql`

### Step 4: Build Looker Studio Dashboard
1. Go to [lookerstudio.google.com](https://lookerstudio.google.com)
2. Create new report → Connect to BigQuery views
3. Build 3 pages: Main Dashboard, Supplier Scorecard, Reorder Now

### Step 5: Set Up Email Alerts
1. Create Google Sheet with low-stock data
2. Go to Extensions → Apps Script
3. Paste code from `/apps_script/low_stock_alert.js`
4. Set daily trigger (8am)


## 📧 Alert System
- **Frequency:** Daily at 8am
- **Trigger:** Stock quantity ≤ Reorder point
- **Delivery:** Gmail


## 📁 File Structure
