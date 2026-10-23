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
ENV PORT=10000
ENV SPRING_PROFILES_ACTIVE=dev

# Database Configuration (Aiven Cloud MySQL)
ENV DB_HOST=mysql-19ea9bc6-onkarsarpane-2682.j.aivencloud.com
ENV DB_PORT=22864
ENV DB_NAME=defaultdb
ENV DB_USER=avnadmin
ENV DB_PASS_B64="QVZOU194VTBZbFhwXzFNZ0c3dnN5SkY3"

# JVM Performance & Container Optimization
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -Dfile.encoding=UTF-8"

# Expose Web Port (Render default port is 10000)
EXPOSE 10000

# Execute Spring Boot Application with Safe Port Fallback
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Dserver.port=${PORT:-10000} -jar app.war"]
