# syntax=docker/dockerfile:1

FROM openjdk:19-jdk-alpine3.16 as builder
WORKDIR /app
COPY . /app/
RUN ./mvnw clean package

FROM openjdk:19-jdk-alpine3.16
ENV NODE_ENV production
WORKDIR /app
RUN addgroup -S group && adduser -S user -G group
USER user
COPY --chown=user:group --from=builder /app/target/spring-boot-data-jpa-0.0.1-SNAPSHOT.jar .
EXPOSE 8080
CMD ["java","-jar","spring-boot-data-jpa-0.0.1-SNAPSHOT.jar"]
