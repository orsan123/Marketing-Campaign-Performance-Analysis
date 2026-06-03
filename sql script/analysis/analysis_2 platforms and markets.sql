USE Funnel_Analysis;


----------------------------------------------------------------------------------------------
-- campaigns with the highest purchases 

SELECT 
    ci.campaign_id, 
    c.name as campaign_name,
    ci.conversion_rate, 
    ci.total_budget,
    ci.cost_per_conversion, 
    ci.Impressions,
    ci.Clicks, 
    ci.Purchases 
FROM campaign_information ci
LEFT JOIN dim_campaigns c  
ON c.campaign_id = ci.campaign_id
ORDER BY Purchases DESC;



----------------------------------------------------------------------------------------------
-- campaigns with the lowest CPAs  

SELECT 
    campaign_id, 
    conversion_rate, 
    total_budget,
    cost_per_conversion, 
    Impressions,
    Clicks, 
    Purchases 
FROM campaign_information 
ORDER BY cost_per_conversion;


----------------------------------------------------------------------------------------------
-- Which platforms were used the most for campaigns?

SELECT 
    ad_platform, 
    COUNT(*) as COUNT,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(10,2)) as perc
FROM dim_ads
    GROUP BY ad_platform 
    ORDER BY COUNT DESC;

/*
    - Facebook had a higher ad allocation compared to Instagram (63.5% vs 38.5%)
    - This may also indicate that marketers already perceive Facebook as a stronger customer acquisition platform 
*/


----------------------------------------------------------------------------------------------
-- Which platform had more traffic?

SELECT 
    ad_platform, 
    COUNT(*) as COUNT,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(10,2)) as perc
FROM fact_ad_events
    GROUP BY ad_platform 
    ORDER BY COUNT DESC;

/*
    - Traffic distribution across platforms mirrored the distribution of ad allocation (63.5% vs 36.5%)
*/



----------------------------------------------------------------------------------------------
--  Which platform converted most efficiently? 

SELECT 
    ad_platform, 

    COUNT(CASE WHEN event_type = 'Click' THEN 1 END) clicked,

    CAST(COUNT(CASE WHEN event_type = 'Click' THEN 1 END) * 100.0 / 
        SUM(COUNT(CASE WHEN event_type = 'Click' THEN 1 END)) OVER() AS DECIMAL(10,2)) clicked_perc,

    COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) purchased,

    CAST(COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) * 100.0/ 
    COUNT(CASE WHEN event_type = 'Click' THEN 1 END) as DECIMAL(10,2)) as conversion_rate
FROM fact_ad_events
GROUP BY ad_platform;

/*
 - Both platforms converted similarly but Facebook demonstrates a modest conversion-efficiency advantage 
   over Instagram.
*/



----------------------------------------------------------------------------------------------
-- What was the distribution of ad allocation across ad types across platforms

SELECT 
    ad_platform,
    ad_type, 
    COUNT(*) as COUNT,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(10,2)) as perc
FROM dim_ads
    GROUP BY ad_platform, ad_type 
    ORDER BY COUNT DESC;

/*
    -  
*/



----------------------------------------------------------------------------------------------
--  Which ad_type in which platform converted the most efficiently?

SELECT 
    ad_platform, 
    ad_type,

    COUNT(CASE WHEN event_type = 'Impression' THEN 1 END) impressions,
    COUNT(CASE WHEN event_type = 'Click' THEN 1 END) clicked,
    COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) purchased,

    CAST(COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) * 100.0/ 
    COUNT(CASE WHEN event_type = 'Click' THEN 1 END) as DECIMAL(10,2)) as conversion_rate
FROM fact_ad_events
GROUP BY ad_platform, ad_type
ORDER BY conversion_rate DESC;

/*
 - Facebook stories converted the highest (5.52%)
 - Instagram images and videos converted the least efficiently (4.3%)
*/






----------------------------------------------------------------------------------------------
--  Which ad_type converted the most efficiently?

SELECT 
    ad_type,

    COUNT(CASE WHEN event_type = 'Impression' THEN 1 END) impressions,
    COUNT(CASE WHEN event_type = 'Click' THEN 1 END) clicked,

    CAST(COUNT(CASE WHEN event_type = 'Click' THEN 1 END) * 100.0 / 
    SUM(COUNT(CASE WHEN event_type = 'Click' THEN 1 END)) OVER() as DECIMAL(10,2)) as perc_clicked,

    COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) purchased,
    
    CAST(COUNT(CASE WHEN event_type = 'Purchase' THEN 1 END) * 100.0/ 
    COUNT(CASE WHEN event_type = 'Click' THEN 1 END) as DECIMAL(10,2)) as conversion_rate
FROM fact_ad_events
GROUP BY ad_type
ORDER BY conversion_rate DESC;

/*
 - Stories and Carousel formats accounted ~57% of total click volume which also has the highest conversion 
   efficiency.
*/
