USE Funnel_Analysis;

----------------------------------------------------------------------------------------------
-- Creating a temporary table for fact ad events with the user data.

DROP TABLE IF EXISTS #fact_ad_events_user_info;
GO

SELECT 
    ae.event_id, 
    ae.campaign_id, 
    ae.user_id, 
    ae.event_type,
    u.user_gender,
    a.target_gender,
    u.age_group, 
    u.country as user_country, 
    ae.ad_platform, 
    ae.ad_type 
INTO #fact_ad_events_user_info
FROM fact_ad_events ae
LEFT JOIN dim_users u
    ON ae.user_id = u.user_id
LEFT JOIN dim_ads a  
    ON ae.campaign_id = a.campaign_id;
GO


----------------------------------------------------------------------------------------------
-- How was gender targeting allocated across the 200 ads?

SELECT 
target_gender, 
count(*) as total_allocations,
CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() as DECIMAL(10,2)) percentage  
FROM dim_ads 
GROUP BY target_gender;

/*
 - Of the 200 ads analyzed, 41.5% of the ads were targeted towards female audiences
 - 23% ads were target towards male audiences 
 - AND 35.5% ads were targeted to all genders.
*/



----------------------------------------------------------------------------------------------
-- Does gender have any correlation with click behavior?

with temp as (
SELECT 
    * 
FROM #fact_ad_events_user_info
WHERE event_type = 'Click'
)
SELECT 
    user_gender, 
    COUNT(*) as count,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() as DECIMAL(10,2)) perc 
FROM temp 
    GROUP BY user_gender 
    ORDER BY perc DESC;

/*
 - Male users represented the dominant segment in click activity, accounting for ~55% of total clicks.
*/



----------------------------------------------------------------------------------------------
-- Which gender target generated the most amount of male clicks?

with temp as (
SELECT 
    * 
FROM #fact_ad_events_user_info
WHERE event_type = 'Click'
AND user_gender = 'Male'
)
SELECT 
    target_gender, 
    COUNT(*) as count,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() as DECIMAL(10,2)) perc 
FROM temp 
    GROUP BY target_gender 
    ORDER BY perc DESC;

/*
 - 76% of the male audience clicked after seeing an ad that was tagreted for either FEMALE or for ALL genders.
*/



----------------------------------------------------------------------------------------------
-- Which gender converted the best?

SELECT 
    user_gender, 

    COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) * 100.0/ 
    COUNT(CASE WHEN event_type = 'Click' THEN 1 END) as conversion_rate
FROM #fact_ad_events_user_info
GROUP BY user_gender
ORDER BY conversion_rate DESC;

/*
 - Conversion rates remained consistent throughout all the gender segments, 
   suggesting no significant gender driven variance in purchasing behavior.
*/



----------------------------------------------------------------------------------------------
-- Does age have any correlation with purchase behavior?

with temp as (
SELECT 
    * 
FROM #fact_ad_events_user_info
WHERE event_type = 'Purchase'
)
SELECT 
    age_group, 
    COUNT(*) as count,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() as DECIMAL(10,2)) perc 
FROM temp 
    GROUP BY age_group 
    ORDER BY perc DESC;

/*
 - 25-34 age cohort accounted for the largest share in purchase behavior, representing 41% of total purchases.
*/



----------------------------------------------------------------------------------------------
-- Does age have any correlation with Click behavior?

with temp as (
SELECT 
    * 
FROM #fact_ad_events_user_info
WHERE event_type = 'Click'
)
SELECT 
    age_group, 
    COUNT(*) as clicks,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() as DECIMAL(10,2)) perc_clicks 
FROM temp 
    GROUP BY age_group 
    ORDER BY perc_clicks DESC;

/*
 - Younger audiences accounts for the larger shares of click volume.
*/



----------------------------------------------------------------------------------------------
-- Which age_group converted the best?

SELECT 
    age_group, 

    COUNT(CASE WHEN event_type = 'Impression' THEN 1 END) impressions,
    COUNT(CASE WHEN event_type = 'Click' THEN 1 END) clicked,
    COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) purchased,

    CAST(COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) * 100.0/ 
    COUNT(CASE WHEN event_type = 'Click' THEN 1 END) as DECIMAL(10,2)) as conversion_rate

FROM #fact_ad_events_user_info
GROUP BY age_group
ORDER BY conversion_rate DESC;

/*
 - Interestingly, despite contributing a relatively smaller share of total purchases, Japan and Mexico demonstrated
   the strongest conversion efficiency. This may indicate the presence of smaller but higher-intent audiences within 
   these markets, presenting opportunities for targetd scaling.
*/



----------------------------------------------------------------------------------------------
-- Which countries had the highest click activity?

WITH country_summary AS (
    SELECT 
        user_country, 
        COUNT(CASE WHEN event_type = 'Impression' THEN 1 END) AS impressions,
        COUNT(CASE WHEN event_type = 'Click' THEN 1 END) AS clicked
    FROM #fact_ad_events_user_info
    GROUP BY user_country
)
SELECT 
    user_country,
    impressions,
    clicked,
    CAST(clicked * 100.0 / SUM(clicked) OVER() AS DECIMAL(10,2)) AS clicked_perc
FROM country_summary
ORDER BY clicked_perc DESC;

/*
 - The US accounted for the largest share in click activity, representing 32% of the total purchases. 
 - Conversely, France recorded the lowest click volume among all the markets analyzed (3%).
*/



----------------------------------------------------------------------------------------------
-- Which countries had the highest Impressions?

WITH country_summary AS (
    SELECT 
        user_country, 
        COUNT(CASE WHEN event_type = 'Impression' THEN 1 END) AS impressions,
        COUNT(CASE WHEN event_type = 'Click' THEN 1 END) AS clicked
    FROM #fact_ad_events_user_info
    GROUP BY user_country
)
SELECT 
    user_country,
    impressions,
    clicked,
    CAST(impressions * 100.0 / SUM(impressions) OVER() AS DECIMAL(10,2)) AS impressions_perc
FROM country_summary
ORDER BY impressions_perc DESC;

/*
 - The US accounted for the largest share in click activity, representing 32% of the total purchases. 
 - Conversely, France recorded the lowest click volume among all the markets analyzed (3%).
*/



----------------------------------------------------------------------------------------------
-- Which country converted the best?

SELECT 
    user_country, 

    COUNT(CASE WHEN event_type = 'Impression' THEN 1 END) impressions,
    COUNT(CASE WHEN event_type = 'Click' THEN 1 END) clicked,
    COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) purchased,

    CAST(COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) * 100.0/ 
    COUNT(CASE WHEN event_type = 'Click' THEN 1 END) as DECIMAL(10,2)) as conversion_rate

FROM #fact_ad_events_user_info
GROUP BY user_country
ORDER BY conversion_rate DESC;

/*
 - Interestingly, despite contributing a relatively smaller share of total purchases, Japan and Mexico demonstrated
   the strongest conversion efficiency. This may indicate the presence of smaller but higher-intent audiences within 
   these markets, presenting opportunities for targetd scaling.
*/








select * from #fact_ad_events_user_info;

select count(*) from #fact_ad_events_user_info;

select * FROM dim_ads;