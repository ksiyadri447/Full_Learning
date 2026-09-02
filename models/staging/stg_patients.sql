/*SELECT
    PATIENT_ID,
    FIRST_NAME,
    LAST_NAME,
    DATE_OF_BIRTH,
    GENDER,
    CITY,
    STATE,
    INSURANCE_ID,
    CREATED_AT,
    UPDATED_AT

FROM HEALTHCARE_DB.RAW_EHR.PATIENTS*/

{{ config(
    materialized='view'
) }}

SELECT

    PATIENT_ID,

    TRIM(FIRST_NAME) AS FIRST_NAME,

    TRIM(LAST_NAME) AS LAST_NAME,

    DATE_OF_BIRTH,

    CASE
        WHEN UPPER(TRIM(GENDER)) IN ('M', 'MALE')
            THEN 'Male'

        WHEN UPPER(TRIM(GENDER)) IN ('F', 'FEMALE')
            THEN 'Female'

        ELSE 'Unknown'
    END AS GENDER,

    INITCAP(TRIM(CITY)) AS CITY,

    INITCAP(TRIM(STATE)) AS STATE,

    INSURANCE_ID,

    CREATED_AT,

    UPDATED_AT

FROM {{ source('ehr', 'patients') }}