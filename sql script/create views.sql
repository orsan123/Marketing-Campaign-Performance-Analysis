USE Funnel_Analysis;
GO 
----------------------------------------------------------------
-- VIEW --> ad_information 


DROP VIEW IF EXISTS ad_information;
GO

CREATE VIEW ad_information AS
SELECT 
ad_id,
COUNT(CASE WHEN event_type = 'Impression' THEN 1 ELSE NULL END) AS Impressions, 
COUNT(CASE WHEN event_type = 'Click' THEN 1 ELSE NULL END) AS Clicks, 
COUNT(CASE WHEN event_type in ('Comment','Share','Like') THEN 1 ELSE NULL END) AS Engagement, 
COUNT(CASE WHEN event_type = 'Purchase' THEN 1 ELSE NULL END) AS Purchases,

CAST(COUNT(CASE WHEN event_type = 'Click' THEN 1 ELSE NULL END) * 100.0 / 
    NULLIF(COUNT(CASE WHEN event_type = 'Impression' THEN 1 ELSE NULL END), 0) AS decimal(10,2)) AS CTR,

CAST(COUNT(CASE WHEN event_type IN ('Like','Comment','Share') THEN 1 ELSE NULL END) * 100.0 / 
    NULLIF(COUNT(CASE WHEN event_type = 'Impression' THEN 1 ELSE NULL END), 0) AS DECIMAL(10, 2)) AS engagement_rate,

CAST(COUNT(CASE WHEN event_type = 'Purchase' THEN 1 ELSE NULL END) * 100.0 / 
    NULLIF(COUNT(CASE WHEN event_type = 'Click' THEN 1 ELSE NULL END), 0) AS DECIMAL(10,2)) AS conversion_rate

FROM fact_ad_events
GROUP BY ad_id;
GO


----------------------------------------------------------------
-- VIEW --> campaign_information 

DROP VIEW IF EXISTS campaign_information;
GO

CREATE VIEW campaign_information AS
SELECT 
ae.campaign_id,
CAST(c.total_budget AS DECIMAL(18,2)) AS total_budget ,
COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 ELSE NULL END) AS Impressions, 
COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 ELSE NULL END) AS Clicks, 
COUNT(CASE WHEN ae.event_type in ('Comment','Share','Like') THEN 1 ELSE NULL END) AS Engagement, 
COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 ELSE NULL END) AS Purchases,

CAST(COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 ELSE NULL END) * 100.0 / 
    NULLIF(COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 ELSE NULL END), 0) AS decimal(10,2)) AS CTR,

CAST(COUNT(CASE WHEN ae.event_type IN ('Like','Comment','Share') THEN 1 ELSE NULL END) * 100.0 / 
    NULLIF(COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 ELSE NULL END), 0) AS DECIMAL(10, 2)) AS engagement_rate,

CAST(COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 ELSE NULL END) * 1.0 / 
    NULLIF(COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 ELSE NULL END), 0) AS DECIMAL(10,2)) AS conversion_rate,

CAST(c.total_budget / COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 ELSE NULL END) AS DECIMAL(18,2)) as cost_per_conversion

FROM fact_ad_events ae  
LEFT JOIN dim_campaigns c
ON ae.campaign_id = c.campaign_id
GROUP BY 
ae.campaign_id,
c.total_budget;
GO

----------------------------------------------------------------

SELECT * FROM ad_information;

SELECT * FROM campaign_information;

SELECT * FROM dim_campaigns;

--------------------------------------------------------------------------------------------------------------------------------


   