# Build stage
#
FROM maven:3.9.9-eclipse-temurin-25 AS build
COPY . .
RUN mvn clean install

#
# Package stage
#
FROM eclipse-temurin:25-jre
COPY --from=build /target/onlineshop-system-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","demo.jar"]