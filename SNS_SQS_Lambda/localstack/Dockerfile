FROM localstack/localstack:latest

RUN apt-get update -y \
&& apt-get upgrade -y \
&& apt-get install -y \
netcat-traditional \
&& apt-get clean -y

COPY ./src /usr/local/bin/
RUN rm -rf /var/lib/apt/lists/*