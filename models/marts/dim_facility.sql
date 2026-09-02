{{ config(
materialized='table'
) }}

SELECT


facility_id AS facility_key,

facility_id,

facility_name,

facility_type,

city,

state,

address,

created_at,

updated_at


FROM {{ ref('stg_facilities') }}
