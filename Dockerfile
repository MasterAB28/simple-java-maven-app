# Use the official Maven image as a base image
FROM maven:3.9.6 AS builder
ARG VERSION=1.0.0
WORKDIR /app

COPY pom.xml .

COPY src src

RUN mvn versions:set -DnewVersion=$VERSION package

FROM openjdk:11-jre-slim
ARG VERSION=1.0.0
WORKDIR /app

COPY --from=builder /app/target/*.jar /app/

CMD ["java", "-jar", "my-app-$VERSION.jar"]
