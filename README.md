# Emergency-Room-Patient-Visits

## Objective
- To identify the demographic factors (e.g., age, gender, race) and key operational metrics (e.g., patient wait times, time of visit, department referrals) to improve operational efficiency and patient satisfaction

## Guiding Questions
- How do average patient wait times differ across various demographic groups (e.g., by age, gender, and race)?
- What is the direct correlation between patient wait times and reported patient satisfaction scores (sat_score)?
- How do patient arrival patterns (e.g., by hour of day or time of visit) influence average patient wait times and subsequent patient satisfaction scores?
- What is the impact of departments (department_referral) on average wait times or satisfaction levels compared to those not referred, or referred to other departments?
- What is the relationship between a patient's admission status (admin_flag) and their average wait time and patient satisfaction score?

## Data Collection
- To retrieve data from Kaggle

## Data Cleaning
- Transformed numerical fields to categorical for further analysis
- Rebuilt missing data for data quality
- Standardized incomplete data for consistent categorical fields

## Data Exploration
- Exploratory data analysis was performed in SQL to answer the guiding questions
- Refer to the separate .sql file for further details

## Data Visualization
- Data visualization was performed in Tableau
- Refer to the separate Tableau data visualization on Tableau Public for further details

## Insights and Recommendations
1. Evening and night hours show consistently high wait times.
    - Re-evaluate and adjust staffing levels and resource allocation (e.g., physician, nurse, support staff) to better match the increased demand and longer wait times.
2. Significant volume of patients with "None" department referral and notable wait times.
    - Implement a rapid assessment or 'fast track' process for patients who do not require specific departmental referrals to quickly evaluate and discharge or refer them.
3. "African American" and "Declined to Identify" patients experience higher average wait times. 
    - Conduct a thorough investigation into the patient journey for these specific demographic groups to identify any specific clinical needs that contribute to their extended wait times.
