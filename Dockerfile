# syntax=docker/dockerfile:1

FROM maven:3.9.5-eclipse-temurin-8-alpine as builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package

FROM openjdk:22-ea-22
ENV NODE_ENV production
WORKDIR /app
RUN addgroup -S group && adduser -S user -G group
USER user
COPY --chown=user:group --from=builder /app/target/spring-boot-data-jpa-0.0.1-SNAPSHOT-exec.jar .
COPY src/main/resources/application.properties /app/application.properties
EXPOSE 8080
CMD ["java","-jar","spring-boot-data-jpa-0.0.1-SNAPSHOT-exec.jar"]

