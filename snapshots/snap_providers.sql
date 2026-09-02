{% snapshot snap_providers %}

{{
config(
target_schema='DBT_DEV_HEALTHCARE',
unique_key='provider_id',
strategy='timestamp',
updated_at='updated_at'
)
}}

SELECT


provider_id,

provider_first_name,

provider_last_name,

specialty,

provider_type,

license_number,

created_at,

updated_at


FROM {{ source('ehr', 'PROVIDERS') }}

{% endsnapshot %}
