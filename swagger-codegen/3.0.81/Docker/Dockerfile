FROM maven:3.8-openjdk-11 AS build

RUN apt-get update && \
  apt-get install -y git && \
  git clone --branch v3.0.81 https://github.com/swagger-api/swagger-codegen && \
  cd swagger-codegen && \
  mvn package && \
  mkdir -p /opt/swagger && \
  cp modules/swagger-codegen-cli/target/swagger-codegen-cli.jar /opt/swagger/ && \
  cd .. && \
  rm -fr swagger-codegen


################################################################################
FROM eclipse-temurin:11-jre

RUN apt-get update && \
  apt-get install -y bash && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /opt/swagger

COPY --from=build /opt/swagger/swagger-codegen-cli.jar /opt/swagger/

COPY configure_user_and_group.bash entrypoint.bash /opt/

ENTRYPOINT ["bash", "/opt/entrypoint.bash"]