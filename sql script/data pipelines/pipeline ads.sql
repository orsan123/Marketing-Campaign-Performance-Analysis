USE Funnel_Analysis;

----------------------------------------------------------------
-- raw table --> raw_ad_events

SELECT * FROM raw_ads;

----------------------------------------------------------------

SELECT COUNT(*) FROM raw_ads;

----------------------------------------------------------------
-- staging table --> stg_ad_events

SELECT 
* 
INTO stg_ads 
FROM raw_ads;

----------------------------------------------------------------
-- final dim table --> dim_ads

SELECT *
INTO dim_ads
FROM stg_ads;

----------------------------------------------------------------
-- full table 

SELECT 
* 
FROM dim_ads;

----------------------------------------------------------------
-- changing ad_id to INT type 

ALTER TABLE dim_ads
ALTER COLUMN ad_id INT NOT NULL;


----------------------------------------------------------------
-- PRIMARY KEY --> event_id

ALTER TABLE dim_ads
ADD CONSTRAINT pk_ad_id PRIMARY KEY (ad_id);

