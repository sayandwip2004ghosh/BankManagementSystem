# ── Stage 1: Build ─────────────────────────────────────────────────────────
FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app

COPY backend/mvnw .
COPY backend/.mvn .mvn
COPY backend/pom.xml .
RUN chmod +x mvnw && ./mvnw dependency:go-offline -q

COPY backend/src src
RUN ./mvnw package -DskipTests -q

# ── Stage 2: Run ───────────────────────────────────────────────────────────
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

RUN addgroup -S bank && adduser -S bank -G bank
USER bank

COPY --from=build /app/target/banking-system-*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
