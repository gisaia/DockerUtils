FROM openjdk:8
WORKDIR /opt/app

# install script dependencies
RUN apt-get update && apt-get install -y bash netcat-openbsd curl

ADD elastic-apm-agent-*.jar /opt/app/elastic-apm-agent.jar