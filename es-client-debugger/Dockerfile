FROM maven:3.5-jdk-8-alpine AS build
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package

FROM openjdk:8-jre-alpine
COPY --from=build /app/target/es-client-debugger-7.3.2.jar /app/es-client-debugger-7.3.2.jar
ENTRYPOINT ["java","-jar","/app/es-client-debugger-7.3.2.jar"]