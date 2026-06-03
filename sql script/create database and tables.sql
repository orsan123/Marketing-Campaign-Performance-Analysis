-- creating database

CREATE DATABASE Funnel_Analysis;

USE Funnel_Analysis;

-- creating a table to store raw_ad_events

CREATE TABLE raw_ad_events
(
    event_id INT, 
    ad_id INT, 
    user_id INT,
    timestamp TIMESTAMP, 
    day_of_week VARCHAR(50),
    time_of_day VARCHAR(50),
    event_type VARCHAR(30)
);

-- creating a table to store raw_ads
CREATE TABLE raw_ads
(
    ad_id INT, 
    campaign_id INT, 
    ad_platform VARCHAR(100), 
    ad_type VARCHAR(50),
    target_gender VARCHAR(30),
    target_age_group VARCHAR(20),
    target_interests VARCHAR(200)
);


-- creating a table for raw_campaigns
CREATE TABLE raw_campaigns
(
    campaign_id INT, 
    campaign_name VARCHAR(200), 
    start_date DATE, 
    end_date DATE, 
    duration_days INT, 
    total_budget DECIMAL(15, 2)
);

-- creating a table to store raw_users
CREATE TABLE raw_users
(
    user_id VARCHAR(20), 
    user_gender VARCHAR(20), 
    user_age TINYINT, 
    age_group VARCHAR(100), 
    country VARCHAR(150), 
    location VARCHAR(200),
    interests VARCHAR(200)
);