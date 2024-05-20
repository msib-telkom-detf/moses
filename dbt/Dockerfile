FROM python:3.8.13

# Instal dependensi dan tools yang diperlukan
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        gnupg \
        curl \
        apt-transport-https \
        ca-certificates \
        software-properties-common

# Tambahkan kode aplikasi Anda
ADD . /usr/src/dbt

# Instal dbt dan dependensinya
RUN pip install dbt-core
RUN pip install dbt-clickhouse

# Tentukan folder kerja
WORKDIR /usr/src/dbt
