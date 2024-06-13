{{ config(materialized='view') }}

with dim_user as (
    SELECT 
        ROW_NUMBER() OVER () AS user_id,
        age,
        gender,
        relationship_status,
        occupation_status,
        affiliated_organization,
        average_daily_use_of_social_media
    FROM
        {{ source('structured_data', 'social_media_mental_health') }}
)
SELECT * FROM dim_user