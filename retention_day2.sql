WITH first_seen AS (					
SELECT					
user_pseudo_id,					
DATE(MIN(TIMESTAMP_MICROS(event_timestamp))) AS signup_date					
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`					
WHERE _TABLE_SUFFIX BETWEEN '20210101' AND '20210107'					
GROUP BY user_pseudo_id					
),					
					
day_2_visits AS (					
SELECT					
user_pseudo_id,					
DATE(TIMESTAMP_MICROS(event_timestamp)) AS visit_date					
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`					
WHERE _TABLE_SUFFIX BETWEEN '20210101' AND '20210110'					
),					
					
retention_calc AS (					
SELECT					
f.signup_date,					
COUNT(DISTINCT f.user_pseudo_id) AS users_signed_up,					
COUNT(DISTINCT d.user_pseudo_id) AS users_retained_day2					
FROM first_seen f					
LEFT JOIN day_2_visits d					
ON f.user_pseudo_id = d.user_pseudo_id					
AND d.visit_date = DATE_ADD(f.signup_date, INTERVAL 2 DAY)					
GROUP BY f.signup_date					
)					
					
SELECT					
signup_date,					
users_signed_up,					
users_retained_day2,					
ROUND(users_retained_day2 / users_signed_up, 4) AS retention_day_2_rate					
FROM retention_calc					
ORDER BY signup_date					
