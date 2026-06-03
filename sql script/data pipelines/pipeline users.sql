USE Funnel_Analysis;

----------------------------------------------------------------
-- raw table --> raw_ad_events

SELECT * FROM raw_users;

----------------------------------------------------------------

SELECT COUNT(*) FROM raw_users;

----------------------------------------------------------------
-- staging table --> stg_users
-- keeping only the original records

WITH temp as 
(
    SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY (SELECT NULL)) as rn
    from raw_users
) 
SELECT 
    user_id, 
    user_gender, 
    user_age, 
    age_group, 
    country,
    location, 
    interests
INTO stg_users
FROM temp
WHERE rn = 1;

----------------------------------------------------------------
-- final dim table --> dim_users

SELECT * 
INTO dim_users
FROM stg_users;

----------------------------------------------------------------
-- PRIMARY KEY --> user_id

ALTER TABLE dim_users 
ADD CONSTRAINT pk_user_id PRIMARY KEY (user_id);

----------------------------------------------------------------
-- view table

SELECT * FROM dim_users;

----------------------------------------------------------------
-- count rows

SELECT COUNT(*) FROM stg_users;