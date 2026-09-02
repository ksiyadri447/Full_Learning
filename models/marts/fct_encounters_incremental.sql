{{ config(
materialized='incremental',
unique_key='encounter_id',
incremental_strategy='merge',
on_schema_change='sync_all_columns'
) }}

SELECT
encounter_id,
patient_id,
provider_id,
facility_id,
encounter_type,
admission_datetime,
discharge_datetime,
status,
created_at,
updated_at,
is_deleted

FROM {{ ref('stg_encounters') }}

{% if is_incremental() %}

WHERE updated_at >= DATEADD(
day,
-3,
(
SELECT MAX(updated_at)
FROM {{ this }}
)
)

{% endif %}
