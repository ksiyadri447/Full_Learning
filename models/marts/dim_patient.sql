{{ config(
materialized='table'
) }}

SELECT
p.patient_id,
p.first_name,
p.last_name,
p.date_of_birth,
p.gender,
p.city,
p.state,
p.insurance_id,

i.insurance_name,
i.insurance_type,
i.plan_name


FROM {{ ref('stg_patients') }} p

LEFT JOIN {{ ref('stg_insurance') }} i
ON p.insurance_id = i.insurance_id
