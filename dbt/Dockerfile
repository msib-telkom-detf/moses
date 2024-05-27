# FROM python:3.8.13

# RUN apt-get update \
#     && apt-get install -y --no-install-recommends

# ADD . /usr/src/dbt/imdb

# RUN pip install dbt-core
# RUN pip install dbt-clickhouse

FROM python:3.8.13

# Install necessary packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       openssh-server  # Install SSH server

# Add dbt files
ADD . /usr/src/dbt/imdb

# Install dbt and dbt-clickhouse
RUN pip install dbt-core dbt-clickhouse

# Create a dbt user
RUN useradd -ms /bin/bash dbt_user

# Set up SSH keys (assuming you have ssh keys generated and placed in the ssh directory)
RUN mkdir -p /home/dbt_user/.ssh && \
    chmod 700 /home/dbt_user/.ssh && \
    touch /home/dbt_user/.ssh/authorized_keys && \
    chmod 600 /home/dbt_user/.ssh/authorized_keys

# Copy SSH public key
COPY ./.ssh/id_rsa.pub /home/dbt_user/.ssh/authorized_keys

# Set ownership
RUN chown -R dbt_user:dbt_user /home/dbt_user

# Expose SSH port
EXPOSE 22

# Start the SSH service
CMD ["/usr/sbin/sshd", "-D"]

