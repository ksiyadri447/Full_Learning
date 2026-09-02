SELECT

provider_id,

INITCAP(TRIM(provider_first_name)) AS provider_first_name,

INITCAP(TRIM(provider_last_name)) AS provider_last_name,

CASE
    WHEN UPPER(TRIM(specialty)) = 'CARDIOLOGY'
        THEN 'Cardiology'

    WHEN UPPER(TRIM(specialty)) = 'EMERGENCY MEDICINE'
        THEN 'Emergency Medicine'

    WHEN UPPER(TRIM(specialty)) = 'PEDIATRICS'
        THEN 'Pediatrics'

    ELSE 'Other'
END AS specialty,

CASE
    WHEN UPPER(TRIM(provider_type)) = 'PHYSICIAN'
        THEN 'Physician'

    ELSE 'Other'
END AS provider_type,

TRIM(license_number) AS license_number,

created_at,

updated_at


FROM {{ source('ehr', 'PROVIDERS') }}