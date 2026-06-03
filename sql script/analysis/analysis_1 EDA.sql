USE Funnel_Analysis;

----------------------------------------------------------------
-- campaigns 16 and 43 does not exist in the events table 

SELECT * FROM dim_campaigns
WHERE campaign_id NOT IN 
(
    SELECT DISTINCT campaign_id 
    FROM fact_ad_events
);



----------------------------------------------------------------
-- campaigns 16 and 43 does not have any data  

SELECT 
c.campaign_id, 
COUNT(a.ad_id) as number_of_ads
FROM dim_campaigns c  
LEFT JOIN dim_ads a   
ON c.campaign_id = a.campaign_id
GROUP BY c.campaign_id
ORDER BY number_of_ads;



----------------------------------------------------------------------------------------------
-- the duration of the campaigns are within the time period of the events table 

-- INFERENCE:
    -- Either the campaigns ran and there was no engagement which is not likely OR 
    -- More likely their engagement data was not recorded which is data inconsistency.

SELECT 
campaign_id, 
name, 
start_date, 
end_date
FROM dim_campaigns
WHERE campaign_id IN ('16','43');


SELECT 
MIN(event_date) as first_date, 
MAX(event_date) as last_date 
FROM fact_ad_events;




----------------------------------------------------------------------------------------------

SELECT 
* 
FROM fact_ad_events;

----------------------------------------------------------------------------------------------

SELECT 
* 
FROM dim_ads;

----------------------------------------------------------------------------------------------

SELECT 
* 
FROM dim_campaigns;

----------------------------------------------------------------------------------------------

SELECT 
* 
FROM dim_users;


