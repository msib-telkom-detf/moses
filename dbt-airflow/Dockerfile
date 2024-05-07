FROM python:3.8.13

RUN apt-get update \
    && apt-get install -y --no-install-recommends

ADD . /usr/src/dbt/imdb

RUN pip install dbt-core
RUN pip install dbt-clickhouse