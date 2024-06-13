{{ config(materialized='view') }}

with mental_health_fact as (
    SELECT
        u.user_id,
        s.social_media_id,
        m.scale_worries,
        m.scale_difficult_to_concentrate,
        m.scale_feel_depressed,
        m.scale_often_face_issues_regarding_sleep    
    FROM
        {{ source('structured_data', 'social_media_mental_health') }} AS m
    JOIN
        user_dimension u ON m.age = u.age
        AND m.gender = u.gender
        AND m.relationship_status = u.relationship_status
        AND m.occupation_status = u.occupation_status
        AND m.affiliated_organization = u.affiliated_organization
    JOIN
        social_media_dimension s ON m.uses_social_media = s.uses_social_media
        AND m.commonly_used_social_media_platforms = s.commonly_used_social_media_platforms
        AND m.average_daily_use_of_social_media = s.average_daily_use_of_social_media;
)
SELECT * FROM mental_health_fact 
