{{ config(
materialized='table'
) }}

WITH provider_history AS (

SELECT

    {{ dbt_utils.generate_surrogate_key([
        'provider_id',
        'dbt_valid_from'
    ]) }} AS provider_key,

    provider_id,

    provider_first_name,

    provider_last_name,

    provider_first_name || ' ' || provider_last_name AS provider_name,

    specialty,

    provider_type,

    license_number,

    created_at,

    updated_at,

    dbt_valid_from AS valid_from,

    dbt_valid_to AS valid_to,

    CASE
        WHEN dbt_valid_to IS NULL THEN TRUE
        ELSE FALSE
    END AS is_current

FROM {{ ref('snap_providers') }}


),

unknown_provider AS (


SELECT

    'UNKNOWN_PROVIDER' AS provider_key,

    'UNKNOWN' AS provider_id,

    'Unknown' AS provider_first_name,

    'Provider' AS provider_last_name,

    'Unknown Provider' AS provider_name,

    'Unknown' AS specialty,

    'Unknown' AS provider_type,

    'UNKNOWN' AS license_number,

    NULL AS created_at,

    NULL AS updated_at,

    NULL AS valid_from,

    NULL AS valid_to,

    TRUE AS is_current

)

SELECT *
FROM unknown_provider

UNION ALL

SELECT *
FROM provider_history
