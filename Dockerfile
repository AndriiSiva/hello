# Используем образ Maven для сборки
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Используем легковесный JDK-образ для запуска
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

# Запускаем приложение
ENTRYPOINT ["java", "-jar", "app.jar"]
