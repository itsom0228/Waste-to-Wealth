# ==============================================================================
# Dockerfile for Waste to Wealth (Spring Boot 3 + JSP + Java 17)
# Optimized for Render Web Service, Railway, Fly.io, and Cloud Containers
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Build Stage: Compiles Java source and packages executable WAR
# ------------------------------------------------------------------------------
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /workspace

# Copy Maven Project Descriptor and Source
COPY pom.xml .
COPY src ./src

# Build package without running unit tests during Docker image creation
RUN mvn clean package -DskipTests

# ------------------------------------------------------------------------------
# 2. Runtime Stage: Lightweight JRE with pre-configured Environment Variables
# ------------------------------------------------------------------------------
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy built WAR artifact from builder stage
COPY --from=builder /workspace/target/*.war app.war

# ==============================================================================
# ENVIRONMENT VARIABLES (Can be overridden by Render Dashboard if needed)
# ==============================================================================

# Server & Profile Configuration
ENV PORT=8080
ENV SPRING_PROFILES_ACTIVE=dev

# Database Configuration (Default MySQL Credentials)
ENV DB_HOST=localhost
ENV DB_PORT=3306
ENV DB_NAME=waste_to_wealth
ENV DB_USER=root
ENV DB_PASSWORD=Python@123

# Cloud Database URL Override (Optional - leave empty for auto DB_HOST construction)
ENV SPRING_DATASOURCE_URL=""
ENV DATABASE_URL=""

# Render Keep-Alive & Public App URL (Optional override, Render sets RENDER_EXTERNAL_URL)
ENV APP_URL=""
ENV RENDER_EXTERNAL_URL=""

# JVM Performance & Container Optimization
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -Dfile.encoding=UTF-8"

# Expose Web Port
EXPOSE 8080

# Execute Spring Boot Application with Dynamic Port Binding
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Dserver.port=${PORT} -jar app.war"]
