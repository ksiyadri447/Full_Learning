SELECT

facility_id,

TRIM(facility_name) AS facility_name,

CASE
    WHEN UPPER(TRIM(facility_type)) = 'HOSPITAL'
        THEN 'Hospital'

    WHEN UPPER(TRIM(facility_type)) = 'MEDICAL CENTER'
        THEN 'Medical Center'

    WHEN UPPER(TRIM(facility_type)) = 'CLINIC'
        THEN 'Clinic'

    ELSE 'Unknown'
END AS facility_type,

INITCAP(TRIM(city)) AS city,

INITCAP(TRIM(state)) AS state,

TRIM(address) AS address,

created_at,

updated_at


FROM {{ source('ehr', 'FACILITIES') }}