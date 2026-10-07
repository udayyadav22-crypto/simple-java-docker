FROM eclipse-temurin:17-jre

WORKDIR /app

COPY target/simple-java-docker-1.0-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
