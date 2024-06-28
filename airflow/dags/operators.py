import pendulum
from airflow.models.dag import DAG
from airflow.providers.ssh.operators.ssh import SSHOperator
from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator

with DAG(
    dag_id="etl-pipeline",
    schedule="00 14 * * *",
    start_date=pendulum.datetime(2024, 1, 1, tz="Asia/Jakarta"),
    catchup=False,
    tags=["etl-pipeline"],
):
    
    ingest_data = AirbyteTriggerSyncOperator(
        task_id='sync_operator',
        airbyte_conn_id='airbyte_connector',
        connection_id='c0794669-5ac0-44b0-8e41-6114242a496e',
        asynchronous=False,
        timeout=3600,
        wait_seconds=3
    )

    structured_data_dbt_command = """
    cd /usr/src/dbt/social_media_mental_health # Activate dbt virtual environment if needed
    dbt run --profile structured_data_connection --models structured_data # Run dbt command
    """

    unstructured_to_structured_transformation = SSHOperator(
        task_id='run_transform_structured_data_dbt_command',
        ssh_conn_id='dbt_conn',
        command=structured_data_dbt_command,
    )

    dwh_dbt_command = """
    cd /usr/src/dbt/social_media_mental_health # Activate dbt virtual environment if needed
    dbt run --profile dwh_connection --models dw_social_media_mental_health # Run dbt command
    """

    structured_to_dwh_transformation = SSHOperator(
        task_id='run_transform_dwh_dbt_command',
        ssh_conn_id='dbt_conn',
        command=dwh_dbt_command,
    )

    ingest_data >> unstructured_to_structured_transformation >> structured_to_dwh_transformation
