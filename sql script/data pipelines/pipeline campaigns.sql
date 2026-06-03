USE Funnel_Analysis;

----------------------------------------------------------------
-- raw table --> raw_campaigns

SELECT * FROM raw_campaigns;

SELECT COUNT(*) FROM raw_campaigns;

----------------------------------------------------------------
-- staging table --> stg_campaigns

SELECT 
campaign_id, 
name, 
CONVERT(date, start_date) start_date, 
convert(date, end_date) end_date, 
duration_days, 
ROUND(total_budget, 2) as total_budget
INTO stg_campaigns
FROM raw_campaigns;

----------------------------------------------------------------
-- final dim table --> dim_campaigns

SELECT
*
INTO dim_campaigns
FROM stg_campaigns;

----------------------------------------------------------------
-- changing campaign_id --> INT NOT NULL

ALTER TABLE dim_campaigns
ALTER COLUMN campaign_id INT NOT NULL;

----------------------------------------------------------------
-- PRIMARY KEY --> campaign_id

ALTER TABLE dim_campaigns
ADD CONSTRAINT pk_campaign_id PRIMARY KEY (campaign_id);

----------------------------------------------------------------
-- view final dim table
SELECT * FROM dim_campaigns;

-- DROPPING staging table -- for future changes
DROP TABLE stg_campaigns;

-- DROPPING final dim table -- for future changes
DROP TABLE dim_campaigns;