FROM openjdk:17-jdk-slim

WORKDIR /usr/src/myapp

COPY . .

# Install Maven (if it's not already available in the base image)
RUN apt-get update && apt-get install -y maven

EXPOSE 8080

RUN mvn clean package -DskipTests
