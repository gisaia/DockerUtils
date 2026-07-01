#####################
# COMPILATION STAGE #
#####################
FROM maven:3.9.15-eclipse-temurin-17-alpine as build
WORKDIR /opt/build
#install git
RUN apk update && apk upgrade && apk add --no-cache bash git openssh
#clone ets-ogcapi-features10 project
RUN git clone --depth 1 -b 1.9 https://github.com/opengeospatial/ets-ogcapi-features10.git /opt/build
ADD git.patch /opt/build/git.patch
RUN git apply /opt/build/git.patch
ADD testng.xml /opt/build/src/main/resources/org/opengis/cite/ogcapifeatures10/testng.xml

#compile and move jar
RUN mvn clean install && mv /opt/build/target/ets-ogcapi-features10-*-aio.jar /opt/build/ets-ogcapi-features10.jar
###################
# RUN STAGE #
###################
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /opt/app
RUN apk update && apk upgrade && apk add --no-cache bash xmlstarlet 
COPY . /opt/app/
COPY --from=build /opt/build/ets-ogcapi-features10.jar /opt/app/
ENTRYPOINT [ "/opt/app/run.sh" ] 