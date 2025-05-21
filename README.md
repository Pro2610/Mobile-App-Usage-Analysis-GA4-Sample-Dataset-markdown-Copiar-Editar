# Mobile-App-Usage-Analysis-GA4-Sample-Dataset
# 📱 Mobile App Usage Analysis

**Data Source**: [Google Analytics 4 Sample Dataset (BigQuery Public)](https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=ga4_obfuscated_sample_ecommerce)

## 📌 Project Overview

This project analyzes user interaction with a mobile application using event-based data from Google Analytics 4 (GA4). The goal is to extract insights about user behavior, retention, conversion, and monetization over a 7-day period.

---

## 🎯 Key Objectives

- Understand user activity trends (DAU)
- Analyze retention rates (Day 2 and Day 7)
- Measure revenue and monetization (ARPU, ARPPU)
- Build a conversion funnel from product view to purchase

---

## 🧰 Tools & Technologies

- **SQL** (Google BigQuery)
- **GA4 schema**: event-based data structure with nested fields
- **Data period**: `2021-01-01` to `2021-01-07`
  
## 📊 Main Metrics

1. Daily Active Users (DAU)
Number of unique users per day.

 2. Retention Rate
Metric	Description
Day 2 Retention	% of users who returned 2 days after signup
Day 7 Retention	% of users who returned 7 days after signup

Both metrics calculated by comparing signup date to visit date using DATE_ADD(...).

🔹 3. Revenue Analysis
Revenue data was extracted from the purchase event's event_params.value field.

Metric	Description
total_revenue	Total purchase amount
paying_users	Unique users who made a purchase
ARPU	Revenue / Total users
ARPPU	Revenue / Paying users

🔹 4. Conversion Funnel
Funnel stages:
view_item → add_to_cart → purchase

We calculated:

Unique users per stage

% conversion between each stage

Total conversion rate

ROUND(purchase / view_item, 4) AS total_conversion_rate
🧠 Insights
The app had consistent DAU between 200–400 users.

Day 2 retention was ~18–25%, while Day 7 dropped to ~10–20%.

Average ARPU was low (< €2), while ARPPU showed monetization from a small user segment.

Conversion rate from view_item → purchase averaged around 10%.

✅ Next Steps
Visualize results in Tableau or Looker Studio

Segment by country or device

Build cohort retention analysis by week or month


👩‍💻 Author
Yana Prozhuhan
