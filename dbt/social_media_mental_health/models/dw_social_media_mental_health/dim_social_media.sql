{{ config(materialized='view') }}

with dim_social_media as (
    SELECT
        ROW_NUMBER() OVER () AS social_media_id,
        uses_social_media,
        commonly_used_social_media_platforms
    FROM
        {{ source('structured_data', 'social_media_mental_health') }}
    WHERE DATE(timestamp) = SUBDATE(CURDATE(), INTERVAL 1 DAY)
)
SELECT * FROM dim_social_media
