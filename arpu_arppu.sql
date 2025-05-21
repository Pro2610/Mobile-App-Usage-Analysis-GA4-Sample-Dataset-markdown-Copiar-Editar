WITH users AS (				
SELECT				
DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,				
user_pseudo_id				
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`				
WHERE _TABLE_SUFFIX BETWEEN '20210101' AND '20210107'				
),				
				
purchases AS (				
SELECT				
DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,				
user_pseudo_id,				
(SELECT value.double_value				
FROM UNNEST(event_params)				
WHERE key = 'value') AS purchase_value				
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`				
WHERE _TABLE_SUFFIX BETWEEN '20210101' AND '20210107'				
AND event_name = 'purchase'				
),				
				
metrics AS (				
SELECT				
u.event_date,				
COUNT(DISTINCT u.user_pseudo_id) AS total_users,				
COUNT(DISTINCT p.user_pseudo_id) AS paying_users,				
SUM(p.purchase_value) AS total_revenue				
FROM users u				
LEFT JOIN purchases p				
ON u.user_pseudo_id = p.user_pseudo_id				
AND u.event_date = p.event_date				
GROUP BY u.event_date				
)				
				
SELECT				
event_date,				
total_users,				
paying_users,				
total_revenue,				
ROUND(total_revenue / total_users, 2) AS arpu,				
ROUND(total_revenue / paying_users, 2) AS arppu				
FROM metrics				
ORDER BY event_date				
				
