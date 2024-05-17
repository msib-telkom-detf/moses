import pendulum
from airflow.models.dag import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator
from airflow.providers.airbyte.sensors.airbyte import AirbyteJobSensor

with DAG(
    dag_id="testing",
    schedule=None,
    start_date=pendulum.datetime(2024, 1, 1, tz="Asia/Jakarta"),
    catchup=False,
    tags=["testing"],
):
    test_airbyte_conn = AirbyteTriggerSyncOperator(
        task_id='test_airbyte_conn',
        airbyte_conn_id='airbyte_connector',
        connection_id='722049c4-5e54-4388-9d26-3002f42c8af0',
        asynchronous=True
    )

    wait_for_sync_completion = AirbyteJobSensor(
       task_id='airbyte_check_sync',
       airbyte_conn_id='airbyte_connector',
       airbyte_job_id=test_airbyte_conn.output
    )

    test_airbyte_conn >> wait_for_sync_completion 

    # task_dbt_run = BashOperator(
    #     task_id="dbt_run",
    #     bash_command="dbt run --profiles-dir /opt/airflow/dbt/imdb --project-dir /opt/airflow/dbt/imdb",
    # )

    # # task_dbt_test = BashOperator(
    # #     task_id="dbt_test",
    # #     bash_command="dbt test --profiles-dir /opt/airflow/dbt-profiles --project-dir /tmp/pizza_shop",
    # # )

    # task_dbt_run
