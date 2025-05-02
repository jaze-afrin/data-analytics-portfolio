
Parkinson’s Disease Analysis: Movement and Symptoms

Project Overview

This project focuses on the analysis of Parkinson’s Disease (PD) using data from wearable sensors. The dataset includes data on various motor symptoms (tremor, rigidity, bradykinesia, etc.) and non-motor symptoms (NMS) from patients diagnosed with Parkinson's Disease (PD), Differential Diagnosis (DD), and Healthy Controls (HC). The goal was to assess motor symptoms, analyze non-motor symptoms, and visualize the findings using Power BI.

The key aspects of the project include data cleaning, transformation, and creating meaningful visualizations to draw insights about Parkinson's Disease and its impact on the patient's motor and non-motor symptoms.


Data Cleaning and Transformation

Data Sources: The dataset includes movement data from wearable sensors (accelerometer and gyroscope readings) along with responses to a non-motor symptom questionnaire.

Tools Used: Power BI was the primary tool for cleaning and transforming the dataset.

Key Cleaning Steps:

Removed missing values and handled outliers.

Consolidated and transformed sensor data to compute key scores for tremor, bradykinesia, and rigidity.

Aggregated accelerometer and gyroscope readings for analysis.

Processed the 30-item non-motor symptom questionnaire responses for scoring.

Consolidated the dataset for use in visualizations, ensuring clarity and consistency across all records.

Visualizations and Insights
Key Insights:

Demographics:

    The dataset contains 496 patients, with 59.91% male and 40.09% female.

    Most patients fall into the normal weight and overweight categories based on BMI values.

    Patients with a kinship history of Parkinson’s Disease have a higher likelihood of developing PD.


Non-Motor Symptoms (NMS) Analysis:

    The majority of PD patients reported symptoms related to the urinary system, sleep/fatigue, and gastrointestinal issues.

    Pain was the least reported symptom among PD patients.

    Healthy Controls (HC) showed minimal to no non-motor symptoms, contrasting sharply with PD patients.


Motor Symptom Analysis:

    Tremor: Higher tremor activity was observed in the vertical direction (Y-axis), common for PD patients.

    Rigidity: PD and DD patients showed higher rigidity scores compared to HC.

    Bradykinesia: PD and DD patients exhibited slower movements, as reflected in higher bradykinesia scores.
    

Frequency Spectrum Analysis (PSD):

    Power Spectral Density (PSD) analysis showed that tremor activity in PD patients was most pronounced in the frequency range of 4–6 Hz.
    

Jitter and Handedness:

    Jitter was more pronounced in the dominant hand for right-handed individuals during tasks like "LiftHold" and "Weight," showing the impact of neuromuscular control.
    

Key Tasks for Score Calculation:

Tremor Score: Calculated using both amplitude-based and frequency-based measures from sensor data.

Rigidity and Jitter Scores: Computed using accelerometer data from various tasks.

Bradykinesia Score: Based on gyroscope data, calculated from tasks involving fine motor control like "TouchIndex," "LiftHold," and "DrinkGlass."

Challenges Faced

One of the major challenges was consolidating the data from multiple files, including JSON files, ensuring a consistent structure across all datasets.

Consolidating sensor data, including accelerometer and gyroscope readings, was a challenge, especially when dealing with multiple tasks and patient conditions.

Deciding which tasks to include in the analysis for accurate score calculation was another key challenge.

Handling missing or inconsistent data in sensor readings and questionnaire responses, requiring careful aggregation and cleaning.

Tools and Technologies Used

Power BI: For data cleaning, transformation, and visualization. All visualizations and dashboards were created within Power BI.


Conclusion
The project aimed to uncover patterns and insights related to Parkinson's Disease by focusing on both motor and non-motor symptoms. The visualizations built in Power BI offer a comprehensive understanding of how these symptoms affect patients differently based on their diagnosis.

Parkinson’s Disease patients showed high scores in both motor (UPDRS) and non-motor symptoms.

Healthy Controls displayed low to medium scores on motor and non-motor symptom scales, highlighting the contrast between the disease states.

Power BI Dashboard (.pbix)    ---->   
The Power BI Dashboard for the Parkinson’s Disease analysis can be found in the attached .pbix file. This file includes all the visualizations and data transformations used in the project. You can open it in Power BI Desktop to explore the interactive reports and insights.
