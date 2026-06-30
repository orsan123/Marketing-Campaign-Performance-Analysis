# **Marketing Campaign Performance Analysis** | <br>*SQL Server Management Studio, Power BI*

*Identifying campaign inefficiencies and scaling opportunities to improve targeting precision and marketing spend efficiency.*

## Tools

- SQL Server Management Studio - data cleaning, transformation, feature engineering, and building layered reporting logic for scalable analytics
- Power BI (DAX, Data Modeling) - dashboard report, KPI tracking

## Business Scenario

A marketing team had invested in advertising campaigns across multiple platforms to drive customer acquisition. However, campaign results varied significantly, making it difficult to determine whether marketing budget was being allocated efficiently.

To improve acquisition efficiency and reduce wasted spend, an analysis was conducted to evaluate campaign performance over a **three-month period (May 2025 - July 2025)** and identify the audience segments, platforms, and geographic markets associated with stronger conversion outcomes.

Reporting to the Marketing Manager, a comprehensive review of campaign performance and customer acquisition behavior was conducted to **uncover inefficient spending patterns** and **identify opportunities for more effective budget allocation** and future campaign scaling


## Data Structure & ERD (Entity Relationship Diagram)

The database structure as seen below consists of 4 main tables  
- **fact_ad_events**: Stores user interactions and conversion activity generated from advertising campaigns.
- **dim_ads**: Contains details about individual advertisements, including platform, format, and targeting attributes.
- **dim_campaigns**: Contains campaign-level information such as budget allocation and campaign identifiers.
- **dim_users**: Stores user demographic information used for audience and segmentation analysis.

![image alt](https://github.com/user-attachments/assets/207ded77-af18-470c-b19e-9988c8e1a933)

## North Star Metrics

Two main metrics were used within this analysis  

### To evaluate the efficiency of marketing campaigns  
**CPA (Cost Per Acquisition)**: The average amount used to acquire a single
purchase in a campaign.

- A lower CPA indicates that a campaign is generating purchases more efficiently and delivering stronger return on marketing investment.  

### To analyze the acquisition quality of segments

**CVR (Conversion Rate)**: The percentage of people that purchased out of
the total click traffic within the campaign

- A higher CVR indicates that a larger percentage of users who engaged with a campaign ultimately converted into customers.

## Findings and Insights
### 1) Campaign Spend Inefficiency  

- Campaign-level performance revealed significant differences in acquisition efficiency across marketing campaigns, suggesting that higher campaign investment did not consistently generate higher purchases
- Campaign 35 spent approximately **71.6K AED** but generated only **11 purchases**, resulting in a **CPA of 6,511 AED**, the highest acquisition cost among all campaigns.
- In contrast, **Campaign 42** generated **67 purchases** on a **budget** of approximately **8K AED**, achieving a **CPA of 118 AED**, demonstrating significantly stronger acquisition efficiency despite operating on a much smaller budget.
- These findings suggest that marketing budget is not allocated optimally and may present opportunities to improve acquisition efficiency by reallocating budget towards more strongly converting audience segments and markets.

![image alt](https://github.com/user-attachments/assets/7fc698a2-6e9e-463a-80ae-c78b567ad3b0)

### 2) Targeting & Scaling Opportunities

Since campaign spend alone did not consistently explain acquisition performance, a deeper analysis was conducted across platforms, audience segments, and geographic markets to identify where conversion efficiency was strongest.

The objective was to understand which customer segments demonstrated the highest acquisition quality and where future campaign investment could potentially generate stronger returns.

The following analysis highlights the platforms, audience cohorts, and geographic markets that exhibited the strongest balance between conversion efficiency and acquisition scale, providing potential opportunities for more effective budget allocation and campaign scaling.

#### a) Market-level Analysis  

![image alt](https://github.com/user-attachments/assets/9d25988c-0fff-4bf7-ba35-3b132c3b1ae8)

#### b) Audience-level Analysis
#### c) Platform-level Analysis


