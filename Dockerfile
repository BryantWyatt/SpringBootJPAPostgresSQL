# Maven
FROM maven:3.6.3-jdk-11-slim as maven

COPY pom.xml ./app/pom.xml

COPY src ./app/src

WORKDIR /app

RUN mvn package

FROM adoptopenjdk/openjdk11:alpine-jre as openjdk11

# Location of the jar file on the maven stage of the build
ARG MAVEN_JAR_FILE=app/target/SpringBootJPAPostgreSQL-1.0-SNAPSHOT.jar

# Navigate to directory
WORKDIR /app

# Copy contents of jar to Docker image
COPY --from=maven ${MAVEN_JAR_FILE} /app/SpringBootJPAPostgreSQL-1.0-SNAPSHOT.jar

EXPOSE 8080

# Run command
ENTRYPOINT ["java", "-jar", "/app/SpringBootJPAPostgreSQL-1.0-SNAPSHOT.jar"]
