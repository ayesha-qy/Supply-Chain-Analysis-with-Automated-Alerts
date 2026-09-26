-- View: Supplier Performance Scorecard

CREATE OR REPLACE VIEW `inventory-dashboard.ecommerce_data.view_supplier_scorecard` AS
SELECT 
  s.supplier_id,
  s.supplier_name,
  ROUND(AVG(s.lead_time_days), 1) as avg_lead_time,
  ROUND(AVG(s.unit_cost), 2) as avg_cost,
  ROUND(AVG(s.reliability_score), 1) as avg_reliability_score,
  COUNT(DISTINCT p.product_id) as products_supplied
FROM `inventory-dashboard.ecommerce_data.supplier_costs` s
LEFT JOIN `inventory-dashboard.ecommerce_data.products` p 
  ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.supplier_name
ORDER BY avg_reliability_score DESC;
