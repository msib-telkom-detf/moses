import pendulum
from airflow.models.dag import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator

from airflow.providers.ssh.operators.ssh import SSHOperator

# from airflow_clickhouse_plugin.operators.clickhouse import ClickHouseOperator

# from apache.airflow.providers.clickhouse.operators.ClickhouseOperator import ClickhouseOperator


with DAG(
    dag_id="final-project-etl",
    schedule=None,
    start_date=pendulum.datetime(2024, 1, 1, tz="Asia/Jakarta"),
    catchup=False,
    tags=["final-project-etl"],
):
    # dbt_debug_task = SSHOperator(
    #     task_id='dbt_debug',
    #     ssh_conn_id='ssh_dbt',
    #     command='cd imdb && dbt debug',
    # )

    sync_operator = AirbyteTriggerSyncOperator(
        task_id='sync_operator',
        airbyte_conn_id='airbyte_connector',
        connection_id='722049c4-5e54-4388-9d26-3002f42c8af0',
        asynchronous=False,
        timeout=3600,
        wait_seconds=3
    )

    casting_data = ClickHouseOperator(
        task_id='casting_data',
        database='airbyte_internal',
        sql=(
            '''
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
                    testing_social_media_mental_health_raw__stream_testing_data;

            '''
            # result of the last query is pushed to XCom
        ),
        # query_id is templated and allows to quickly identify query in ClickHouse logs
        query_id='{{ ti.dag_id }}-{{ ti.task_id }}-{{ ti.run_id }}-{{ ti.try_number }}',
        clickhouse_conn_id='clickhouse_conn',
    )

    sync_operator >> casting_data

    # task_dbt_run = BashOperator(
    #     task_id="dbt_run",
    #     bash_command="dbt run --profiles-dir /opt/airflow/dbt/imdb --project-dir /opt/airflow/dbt/imdb",
    # )

    # # task_dbt_test = BashOperator(
    # #     task_id="dbt_test",
    # #     bash_command="dbt test --profiles-dir /opt/airflow/dbt-profiles --project-dir /tmp/pizza_shop",
    # # )

    # task_dbt_run
