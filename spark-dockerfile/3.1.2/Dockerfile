FROM openjdk:8-jdk-slim

WORKDIR /opt

ENV PATH="/opt/spark/bin:${PATH}"

RUN apt-get update && apt-get install -y curl unzip \
    && curl -sL --retry 3 \
      "https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop2.7.tgz" \
      | gunzip \
      | tar x -C . \
    && ln -sf spark-3.1.2-bin-hadoop2.7 spark
