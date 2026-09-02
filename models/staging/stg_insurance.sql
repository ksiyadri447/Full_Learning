{{ config(
    materialized='view'
) }}

SELECT

    INSURANCE_ID,

    TRIM(INSURANCE_NAME) AS INSURANCE_NAME,

    INITCAP(TRIM(INSURANCE_TYPE)) AS INSURANCE_TYPE,

    TRIM(PLAN_NAME) AS PLAN_NAME,

    CREATED_AT,

    UPDATED_AT

FROM {{ source('claims', 'insurance') }}