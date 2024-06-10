# dbt/Dockerfile
FROM python:3.8-slim

# Install necessary packages
RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get clean

# Create the SSH directory and set up keys (optional, for simplicity, we skip it here)
RUN mkdir /var/run/sshd

# Set up password for root user (for testing purposes)
RUN echo 'root:password' | chpasswd

# Add custom SSH configuration
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Installation dbt dependencies
RUN pip install dbt-core
RUN pip install dbt-clickhouse

# Expose the SSH port
EXPOSE 22

# Start the SSH service
CMD ["/usr/sbin/sshd", "-D"]