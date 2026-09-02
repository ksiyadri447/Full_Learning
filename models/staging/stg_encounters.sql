SELECT


ENCOUNTER_ID AS encounter_id,

PATIENT_ID AS patient_id,

PROVIDER_ID AS provider_id,

FACILITY_ID AS facility_id,

CASE
    WHEN UPPER(TRIM(ENCOUNTER_TYPE)) = 'OUTPATIENT'
        THEN 'Outpatient'

    WHEN UPPER(TRIM(ENCOUNTER_TYPE)) = 'INPATIENT'
        THEN 'Inpatient'

    WHEN UPPER(TRIM(ENCOUNTER_TYPE)) = 'EMERGENCY'
        THEN 'Emergency'

    WHEN UPPER(TRIM(ENCOUNTER_TYPE)) = 'TELEHEALTH'
        THEN 'Telehealth'

    ELSE 'Unknown'
END AS encounter_type,

ADMISSION_DATETIME AS admission_datetime,

DISCHARGE_DATETIME AS discharge_datetime,

CASE
    WHEN UPPER(TRIM(STATUS)) = 'COMPLETED'
        THEN 'Completed'

    WHEN UPPER(TRIM(STATUS)) = 'CANCELLED'
        THEN 'Cancelled'

    WHEN UPPER(TRIM(STATUS)) = 'SCHEDULED'
        THEN 'Scheduled'

    ELSE 'Unknown'
END AS status,

CREATED_AT AS created_at,

UPDATED_AT AS updated_at,

IS_DELETED AS is_deleted


FROM {{ source('ehr', 'encounters') }}
