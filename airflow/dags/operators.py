import pendulum
from airflow.models.dag import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.operators.ssh import SSHOperator
from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator
# from airflow_clickhouse_plugin.operators.clickhouse import ClickHouseOperator

with DAG(
    dag_id="test-dbt",
    schedule=None,
    start_date=pendulum.datetime(2024, 1, 1, tz="Asia/Jakarta"),
    catchup=False,
    tags=["test-dbt"],
):
    # sync_operator = AirbyteTriggerSyncOperator(
    #     task_id='sync_operator',
    #     airbyte_conn_id='airbyte_connector',
    #     connection_id='722049c4-5e54-4388-9d26-3002f42c8af0',
    #     asynchronous=False,
    #     timeout=3600,
    #     wait_seconds=3
    # )

    dbt_command = """
    cd test_social_media # Activate dbt virtual environment if needed
    dbt run # Run dbt command
    """

    run_dbt = SSHOperator(
        task_id='run_dbt_command',
        ssh_conn_id='dbt_conn',  # SSH connection ID in Airflow
        command=dbt_command,
    )

    run_dbt

    # sync_operator >> casting_data

    # task_dbt_run = BashOperator(
    #     task_id="dbt_run",
    #     bash_command="dbt run --profiles-dir /opt/airflow/dbt/imdb --project-dir /opt/airflow/dbt/imdb",
    # )

    # # task_dbt_test = BashOperator(
    # #     task_id="dbt_test",
    # #     bash_command="dbt test --profiles-dir /opt/airflow/dbt-profiles --project-dir /tmp/pizza_shop",
    # # )

    # task_dbt_run
