{{ config(
materialized='table'
) }}

WITH encounters AS (


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
    updated_at
FROM {{ ref('stg_encounters') }}


),

final AS (


SELECT

    e.encounter_id,

    e.patient_id,

    COALESCE(
        d.provider_key,
        'UNKNOWN_PROVIDER'
    ) AS provider_key,

    e.facility_id,

    e.encounter_type,

    e.admission_datetime,

    e.discharge_datetime,

    CAST(e.admission_datetime AS DATE) AS encounter_date,

    e.status,

    DATEDIFF(
        'minute',
        e.admission_datetime,
        e.discharge_datetime
    ) AS encounter_duration_minutes,

    DATEDIFF(
        'day',
        e.admission_datetime,
        e.discharge_datetime
    ) AS length_of_stay_days,

    CASE
        WHEN e.encounter_type = 'Inpatient'
            THEN TRUE
        ELSE FALSE
    END AS is_inpatient,

    CASE
        WHEN e.encounter_type = 'Emergency'
            THEN TRUE
        ELSE FALSE
    END AS is_emergency,

    e.created_at,

    e.updated_at

FROM encounters e

LEFT JOIN {{ ref('dim_provider') }} d

    ON e.provider_id = d.provider_id

    AND e.admission_datetime >= d.valid_from

    AND (
        e.admission_datetime < d.valid_to
        OR d.valid_to IS NULL
    )


)

SELECT *
FROM final
