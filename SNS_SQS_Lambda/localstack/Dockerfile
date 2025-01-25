FROM localstack/localstack:latest

# Install AWS CLI and other necessary packages
RUN apt-get update && apt-get install -y \
    python3-pip \
    zip \
    unzip \
    && pip install --no-cache-dir awscli-local awscli

# Set up working directory for initialization scripts
WORKDIR /etc/localstack/init/ready.d

# Copy initialization scripts and Lambda files into the container
COPY ./src /etc/localstack/init/ready.d

# Make sure scripts are executable
RUN chmod +x /etc/localstack/init/ready.d/*.sh

# # Expose LocalStack default ports
# EXPOSE 4566 4510-4559
