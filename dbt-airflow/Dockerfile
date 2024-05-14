FROM apache/airflow:2.9.1
COPY ./dbt-airflow/requirements.txt /
RUN pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" -r /requirements.txt

# FROM python:3.8.13

# RUN apt-get update \
#     && apt-get install -y --no-install-recommends

# ADD . /usr/src/dbt/imdb

# RUN pip install dbt-core
# RUN pip install dbt-clickhouse