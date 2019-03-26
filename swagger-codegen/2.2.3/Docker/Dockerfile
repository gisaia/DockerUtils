FROM maven:3.5-jdk-8-alpine as build

RUN apk update && \
  apk add git && \
  git clone --branch v2.2.3 https://github.com/swagger-api/swagger-codegen && \
  cd swagger-codegen && \
  mvn package && \
  mkdir -p /opt/swagger && \
  cp modules/swagger-codegen-cli/target/swagger-codegen-cli.jar /opt/swagger/ && \
  cd .. && \
  rm -fr swagger-codegen


################################################################################
FROM openjdk:8-jre-alpine

RUN apk update && \
  apk add bash

WORKDIR /opt/swagger

COPY --from=build /opt/swagger/swagger-codegen-cli.jar /opt/swagger/

ADD configure_user_and_group.bash entrypoint.bash /opt/
RUN chmod u+x /opt/configure_user_and_group.bash

ENTRYPOINT ["bash", "/opt/entrypoint.bash"]
