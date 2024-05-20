FROM apache/airflow:2.9.1

USER root
RUN apt-get update && apt-get install -y git

USER airflow
RUN pip install apache-airflow-providers-airbyte
RUN pip install airflow-providers-clickhouse
RUN pip install airflow-clickhouse-plugin==1.3.0
