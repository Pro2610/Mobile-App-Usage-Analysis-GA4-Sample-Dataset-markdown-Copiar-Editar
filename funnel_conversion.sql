WITH funnel_events AS (								
SELECT								
event_name,								
user_pseudo_id								
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`								
WHERE _TABLE_SUFFIX BETWEEN '20210101' AND '20210107'								
AND event_name IN ('view_item', 'add_to_cart', 'purchase')								
),								
								
funnel_counts AS (								
SELECT								
event_name,								
COUNT(DISTINCT user_pseudo_id) AS unique_users								
FROM funnel_events								
GROUP BY event_name								
)								
								
SELECT								
MAX(CASE WHEN event_name = 'view_item' THEN unique_users ELSE 0 END) AS viewers,								
MAX(CASE WHEN event_name = 'add_to_cart' THEN unique_users ELSE 0 END) AS cart_adders,								
MAX(CASE WHEN event_name = 'purchase' THEN unique_users ELSE 0 END) AS purchasers,								
ROUND(MAX(CASE WHEN event_name = 'add_to_cart' THEN unique_users ELSE 0 END) * 1.0 /								
MAX(CASE WHEN event_name = 'view_item' THEN unique_users ELSE NULL END), 4) AS view_to_cart_rate,								
ROUND(MAX(CASE WHEN event_name = 'purchase' THEN unique_users ELSE 0 END) * 1.0 /								
MAX(CASE WHEN event_name = 'add_to_cart' THEN unique_users ELSE NULL END), 4) AS cart_to_purchase_rate,								
ROUND(MAX(CASE WHEN event_name = 'purchase' THEN unique_users ELSE 0 END) * 1.0 /								
MAX(CASE WHEN event_name = 'view_item' THEN unique_users ELSE NULL END), 4) AS total_conversion_rate								
								
FROM funnel_counts								
