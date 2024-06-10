{{ config(materialized='view') }}

with airbyte_data as (
    SELECT 
        _airbyte_data
    FROM 
        {{ source('airbyte_internal', 'testing_social_media_mental_health_raw__stream_testing_data') }}
)

SELECT 
    parseDateTimeBestEffort(JSONExtractString(_airbyte_data, 'timestamp')) AS timestamp,
    JSONExtractFloat(_airbyte_data, '_1__what_is_yourage') AS "_1__What_is_yourage",
    JSONExtractString(_airbyte_data, '_2__gender') AS "_2__Gender",
    JSONExtractString(_airbyte_data, '_3__relationship_status') AS "_3__Relationship_Status",
    JSONExtractString(_airbyte_data, '_4__occupation_status') AS "_4__Occupation_Status",
    JSONExtractString(_airbyte_data, '_5__what_type_of_organizations_are_you_affiliatedwith') AS "_5__What_type_of_organizations_are_you_affiliatedwith",
    JSONExtractBool(_airbyte_data, '_6__do_you_use_socialmedia') AS "_6__Do_you_use_socialmedia",
    JSONExtractString(_airbyte_data, '_7__what_social_media_platforms_do_you_commonlyuse') AS "_7__What_social_media_platforms_do_you_commonlyuse",
    JSONExtractString(_airbyte_data, '_8__what_is_the_average_time_you_spend_on_social_media_everyday') AS "_8__What_is_the_average_time_you_spend_on_social_media_everyday",
    JSONExtractInt(_airbyte_data, '_9__how_often_do_you_find_yourself_using_social_media_without_a') AS "_9__How_often_do_you_find_yourself_using_Social_media_without_a_specificpurpose"
FROM 
    airbyte_data
