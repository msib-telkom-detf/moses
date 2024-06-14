{{ config(materialized='view') }}

with airbyte_data as (
    SELECT 
        _airbyte_data
    FROM 
        {{ source('airbyte_internal', 'unstructured_data_raw__stream_smmh') }}
)

SELECT 
    parseDateTimeBestEffort(JSONExtractString(_airbyte_data, 'timestamp')) AS "timestamp",
    JSONExtractInt(_airbyte_data, 'age') AS "age",
    JSONExtractString(_airbyte_data, 'gender') AS "gender",
    JSONExtractString(_airbyte_data, 'relationship_status') AS "relationship_status",
    JSONExtractString(_airbyte_data, 'occupation_status') AS "occupation_status",
    JSONExtractString(_airbyte_data, 'affiliated_organization') AS "affiliated_organization",
    JSONExtractBool(_airbyte_data, 'uses_social_media') AS "uses_social_media",
    JSONExtractString(_airbyte_data, 'commonly_used_social_media_platforms') AS "commonly_used_social_media_platforms",
    JSONExtractString(_airbyte_data, 'average_daily_use_of_social_media') AS "average_daily_use_of_social_media",
    JSONExtractInt(_airbyte_data, 'scale_worries') AS "scale_worries",
    JSONExtractInt(_airbyte_data, 'scale_difficult_to_concentrate') AS "scale_difficult_to_concentrate",
    JSONExtractInt(_airbyte_data, 'scale_feel_depressed') AS "scale_feel_depressed",
    JSONExtractInt(_airbyte_data, 'scale_often_face_issues_regarding_sleep') AS "scale_often_face_issues_regarding_sleep"
FROM 
    airbyte_data
