# ==============================================================================
# Dockerfile for Waste to Wealth (Spring Boot 3 + JSP + Java 17)
# Ideal for Render Web Service, Railway, Fly.io, or any container platform
# ==============================================================================

# Build Stage
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /workspace
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime Stage
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=builder /workspace/target/*.war app.war

# Default Render port is 10000 (or passed via PORT env var)
ENV PORT=8080
ENV SPRING_PROFILES_ACTIVE=dev
EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java -Dserver.port=${PORT} -jar app.war"]
