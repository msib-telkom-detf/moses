{{ config(materialized='view') }}

with fact_mental_health as (
    SELECT
        ROW_NUMBER() OVER () AS user_id,
        ROW_NUMBER() OVER () AS social_media_id,
        scale_difficult_to_concentrate,
        scale_feel_depressed,
        scale_often_face_issues_regarding_sleep,
        scale_worries   
    FROM
        {{ source('structured_data', 'social_media_mental_health') }} 
)
SELECT * FROM fact_mental_health 
