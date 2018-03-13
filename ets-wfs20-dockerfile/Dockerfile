#####################
# COMPILATION STAGE #
#####################
FROM maven:3.5-jdk-8-alpine as build
WORKDIR /opt/build
#install git
RUN apk update && apk upgrade && apk add --no-cache bash git openssh
#clone ets-wfs20 project
RUN git clone https://github.com/opengeospatial/ets-wfs20.git  /opt/build
#compile and move jar
RUN mvn install && mv /opt/build/target/ets-wfs20-*-aio.jar /opt/build/ets-wfs20.jar
###################
# RUN STAGE #
###################
FROM openjdk:8-jre-alpine
WORKDIR /opt/app
RUN apk update && apk upgrade && apk add --no-cache bash xmlstarlet 
COPY . /opt/app/
COPY --from=build /opt/build/ets-wfs20.jar /opt/app/
CMD /opt/app/run.sh