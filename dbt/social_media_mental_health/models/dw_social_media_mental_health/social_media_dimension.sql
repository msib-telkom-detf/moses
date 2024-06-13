{{ config(materialized='view') }}

with social_media_dimension as (
    SELECT
        ROW_NUMBER() OVER () AS social_media_id,
        uses_social_media,
        commonly_used_social_media_platforms 
    FROM
        {{ source('structured_data', 'social_media_mental_health') }}
)
SELECT * FROM social_media_dimension
