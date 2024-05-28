import pendulum
from airflow.models.dag import DAG
from airflow.providers.ssh.operators.ssh import SSHOperator
from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator

with DAG(
    dag_id="etl-pipeline",
    schedule=None,
    start_date=pendulum.datetime(2024, 1, 1, tz="Asia/Jakarta"),
    catchup=False,
    tags=["etl-pipeline"],
):
    
    ingest_data = AirbyteTriggerSyncOperator(
        task_id='sync_operator',
        airbyte_conn_id='airbyte_connector',
        connection_id='722049c4-5e54-4388-9d26-3002f42c8af0',
        asynchronous=False,
        timeout=3600,
        wait_seconds=3
    )

    dbt_command = """
    cd /usr/src/dbt/test_social_media # Activate dbt virtual environment if needed
    dbt run # Run dbt command
    """

    cast_json_data = SSHOperator(
        task_id='run_dbt_command',
        ssh_conn_id='dbt_conn',
        command=dbt_command,
    )

    ingest_data >> cast_json_data
