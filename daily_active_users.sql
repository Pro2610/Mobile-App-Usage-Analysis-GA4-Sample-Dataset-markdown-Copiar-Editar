SELECT				
DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,				
COUNT(DISTINCT user_pseudo_id) AS dau				
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`				
WHERE _TABLE_SUFFIX BETWEEN '20210101' AND '20210107'				
GROUP BY event_date				
ORDER BY event_date				
				
