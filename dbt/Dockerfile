# FROM python:3.8.13

# RUN apt-get update \
#     && apt-get install -y --no-install-recommends

# ADD . /usr/src/dbt/imdb

# RUN pip install dbt-core
# RUN pip install dbt-clickhouse

# dbt/Dockerfile
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    ssh \
    dbt

# Set up SSH keys directory
RUN mkdir -p /home/dbt_user/.ssh

# Expose SSH port
EXPOSE 22

# Start the SSH service
CMD ["/usr/sbin/sshd", "-D"]


