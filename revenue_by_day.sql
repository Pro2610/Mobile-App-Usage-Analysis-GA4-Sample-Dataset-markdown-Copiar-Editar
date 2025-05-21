SELECT					
DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,					
COUNT(DISTINCT user_pseudo_id) AS paying_users,					
SUM(					
(SELECT value.double_value					
FROM UNNEST(event_params)					
WHERE key = 'value')					
) AS total_revenue					
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`					
WHERE _TABLE_SUFFIX BETWEEN '20210101' AND '20210107'					
AND event_name = 'purchase'					
GROUP BY event_date					
ORDER BY event_date					
					
					
