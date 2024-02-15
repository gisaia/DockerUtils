FROM maven:3.8-jdk-11 as build

RUN apt update && \
  apt install -y git && \
  git clone --branch v3.0.42 https://github.com/swagger-api/swagger-codegen && \
  cd swagger-codegen && \
  mvn package && \
  mkdir -p /opt/swagger && \
  cp modules/swagger-codegen-cli/target/swagger-codegen-cli.jar /opt/swagger/ && \
  cd .. && \
  rm -fr swagger-codegen


################################################################################
FROM openjdk:11-jre-slim

RUN apt update && \
  apt install -y bash

WORKDIR /opt/swagger

COPY --from=build /opt/swagger/swagger-codegen-cli.jar /opt/swagger/

ADD configure_user_and_group.bash entrypoint.bash /opt/

ENTRYPOINT ["bash", "/opt/entrypoint.bash"]
