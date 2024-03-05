# Use the official Maven image as a base image
FROM maven:3.9.6 AS builder
WORKDIR /app

COPY pom.xml .

COPY src src

RUN mvn clean install

FROM openjdk:11-jre-slim

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "my-app-1.0.0.jar"]
