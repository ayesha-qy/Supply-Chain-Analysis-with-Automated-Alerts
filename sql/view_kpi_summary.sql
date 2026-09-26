-- View: KPI Summary for Scorecards

CREATE OR REPLACE VIEW `your-bigquery-projectname.view_kpi_summary` AS
SELECT 
  COUNT(DISTINCT p.product_id) as total_products,
  ROUND(AVG(i.stock_quantity), 1) as avg_stock_quantity,
  ROUND(AVG(
    CASE 
      WHEN COALESCE(sales.total_sold, 0) > 0 
      THEN i.stock_quantity / (sales.total_sold / 365.0)
      ELSE NULL 
    END
  ), 1) as avg_days_of_inventory,
  ROUND(
    COUNT(CASE WHEN i.stock_quantity <= i.reorder_point THEN 1 END) * 100.0 / 
    COUNT(DISTINCT p.product_id), 1
  ) as pct_products_below_reorder,
  COUNT(CASE WHEN i.stock_quantity <= i.reorder_point THEN 1 END) as products_need_reorder
FROM `your-bigquery-projectname.products` p
JOIN `your-bigquery-projectname.inventory` i 
  ON p.product_id = i.product_id
LEFT JOIN (
  SELECT 
    product_id,
    SUM(quantity) as total_sold
  FROM `your-bigquery-projectname.transactions`
  GROUP BY product_id
) sales ON p.product_id = sales.product_id;
