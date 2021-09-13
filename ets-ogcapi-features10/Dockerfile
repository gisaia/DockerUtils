#####################
# COMPILATION STAGE #
#####################
FROM maven:3.5-jdk-8-alpine as build
WORKDIR /opt/build
#install git
RUN apk update && apk upgrade && apk add --no-cache bash git openssh
#clone ets-ogcapi-features10 project
RUN git clone --depth 1 -b 1.3 https://github.com/opengeospatial/ets-ogcapi-features10.git /opt/build
ADD testng.xml /opt/build/src/main/resources/org/opengis/cite/ogcapifeatures10/testng.xml

#compile and move jar
RUN mvn install && mv /opt/build/target/ets-ogcapi-features10-*-aio.jar /opt/build/ets-ogcapi-features10.jar
###################
# RUN STAGE #
###################
FROM openjdk:8-jre-alpine
WORKDIR /opt/app
RUN apk update && apk upgrade && apk add --no-cache bash xmlstarlet 
COPY . /opt/app/
COPY --from=build /opt/build/ets-ogcapi-features10.jar /opt/app/
CMD /opt/app/run.sh