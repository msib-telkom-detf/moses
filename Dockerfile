FROM apache/airflow:2.9.1

USER root
RUN apt-get update && apt-get install -y git

USER airflow
RUN pip install pendulum==2.1.2
RUN pip install apache-airflow-providers-airbyte
RUN pip install airflow-clickhouse-plugin==0.11.0
