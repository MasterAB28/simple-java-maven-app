# Use the official Maven image as a base image
FROM maven:3.9.6 AS builder
ARG VERSION
WORKDIR /app

COPY pom.xml .

COPY src src

RUN mvn versions:set -DnewVersion=$VERSION 
RUN mvn package

FROM openjdk:11-jre-slim
ARG VERSION
ENV VERSION=${VERSION}
WORKDIR /app

COPY --from=builder /app/target/*.jar /app/

CMD java -jar my-app-*.jar