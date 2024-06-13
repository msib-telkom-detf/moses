{{ config(materialized='view') }}

with mental_health_fact as (
    SELECT
        m.user_id,
        m.social_media_id,
        m.scale_worries,
        m.scale_difficult_to_concentrate,
        m.scale_feel_depressed,
        m.scale_often_face_issues_regarding_sleep    
    FROM
        {{ source('structured_data', 'social_media_mental_health') }} AS m
    JOIN
        user_dimension u ON m.user_id = u.user_id
    JOIN
        social_media_dimension s ON m.social_media_id = s.social_media_id;
)
SELECT * FROM mental_health_fact 
