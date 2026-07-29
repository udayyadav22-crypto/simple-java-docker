FROM eclipse-temurin:17-jdk-alpine

LABEL maintainer="your-email@example.com"
LABEL version="1.0"
LABEL description="A simple Java application"

WORKDIR /app

COPY src/Main.java /app/Main.java

RUN javac Main.java

CMD ["java", "Main"]
