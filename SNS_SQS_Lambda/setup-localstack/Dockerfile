FROM amazonlinux:2023

# Install AWS CLI and other necessary packages
RUN dnf update -y \
    && dnf install -y --allowerasing \
    awscli python3 python3-pip 
RUN pip3 install --no-cache-dir boto3 awscli-local awscli \ 
    && rm -rf /var/cache/dnf/* \ 
    && dnf clean all

# Copy initialization scripts and Lambda files into the container
COPY ./src/ /usr/local/bin/

RUN chmod +x /usr/local/bin/setup.sh
# Make sure scripts are executable
ENTRYPOINT /usr/local/bin/setup.sh