-- View: Master Dashboard View
-- Purpose: Combines products, inventory, and sales for main dashboard table

CREATE OR REPLACE VIEW `inventory-dashboard.ecommerce_data.view_dashboard_master` AS
SELECT 
  p.product_id,
  p.product_name,
  p.category,
  p.brand,
  i.stock_quantity,
  i.reorder_point,
  i.warehouse_id,
  COALESCE(sales.total_sold, 0) as total_sold,
  ROUND(COALESCE(sales.total_sold, 0) / 365.0, 2) as avg_daily_sold,
  CASE 
    WHEN COALESCE(sales.total_sold, 0) > 0 
    THEN ROUND(i.stock_quantity / (sales.total_sold / 365.0), 1)
    ELSE 999 
  END as days_of_inventory,
  CASE 
    WHEN i.stock_quantity <= i.reorder_point THEN 'ORDER NOW'
    WHEN i.stock_quantity <= i.reorder_point * 1.5 THEN 'ORDER SOON'
    ELSE 'OK'
  END as reorder_status
FROM `your-bigquery-projectname.products` p
JOIN `your-bigquery-projectname.inventory` i 
  ON p.product_id = i.product_id
LEFT JOIN (
  SELECT 
    product_id,
    SUM(quantity) as total_sold
  FROM `your-bigquery-projectname.ecommerce_data.transactions`
  GROUP BY product_id
) sales ON p.product_id = sales.product_id;
