USE Funnel_Analysis;

----------------------------------------------------------------
-- raw table --> raw_ad_events

SELECT * FROM raw_ad_events;

SELECT COUNT(*) FROM raw_ad_events;

----------------------------------------------------------------

SELECT COUNT(*) FROM raw_ad_events;

SELECT COUNT(DISTINCT event_id) FROM raw_ad_events;

----------------------------------------------------------------
-- staging table --> stg_ad_events

DROP TABLE IF EXISTS stg_ad_events;
GO

SELECT 
    ae.event_id,
    ae.ad_id, 
    ad.campaign_id,
    ae.user_id, 
    ae.event_type, 
    ad.ad_platform,
    ad.ad_type,
    CONVERT(date, ae.timestamp) event_date, 
    CONVERT(time, ae.timestamp) event_time,
    ae.day_of_week, 
    ae.time_of_day
INTO stg_ad_events
FROM raw_ad_events ae
LEFT JOIN dim_ads ad
    ON ae.ad_id = ad.ad_id;
GO



----------------------------------------------------------------
-- final table --> final_ad_events
DROP TABLE IF EXISTS fact_ad_events;
GO

SELECT *
INTO fact_ad_events
FROM stg_ad_events;
GO



----------------------------------------------------------------
-- view fact table 

SELECT 
* 
FROM fact_ad_events;



----------------------------------------------------------------
-- changing event_id to INT type 

ALTER TABLE fact_ad_events
ALTER COLUMN event_id INT NOT NULL;



----------------------------------------------------------------
-- changing ad_id to INT type

ALTER TABLE fact_ad_events
ALTER COLUMN ad_id INT NOT NULL;



----------------------------------------------------------------
-- changing ad_id to INT type

ALTER TABLE fact_ad_events
ALTER COLUMN campaign_id INT NOT NULL;



----------------------------------------------------------------
-- PRIMARY KEY --> event_id

ALTER TABLE fact_ad_events
ADD CONSTRAINT pk_event_id PRIMARY KEY (event_id);

----------------------------------------------------------------
-- FOREIGN KEY --> ad_id

ALTER TABLE fact_ad_events
ADD CONSTRAINT fk_ad_id_events FOREIGN KEY (ad_id) REFERENCES dim_ads(ad_id);

----------------------------------------------------------------
-- FOREIGN KEY --> campaign_id

ALTER TABLE fact_ad_events
ADD CONSTRAINT fk_campaign_id_ad_events FOREIGN KEY (campaign_id) REFERENCES dim_campaigns(campaign_id);















SELECT 
    ae.event_id,
    ae.ad_id, 
    ad.campaign_id,
    ae.user_id, 
    ae.event_type, 
    ad.ad_platform,
    ad.ad_type,
    CONVERT(date, ae.timestamp) event_date, 
    CONVERT(time, ae.timestamp) event_time,
    ae.day_of_week, 
    ae.time_of_day
FROM raw_ad_events ae
LEFT JOIN dim_ads ad
    ON ae.ad_id = ad.ad_id;