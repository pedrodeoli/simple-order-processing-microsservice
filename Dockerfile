# Build stage using Maven 3.5 and Java 11
FROM maven:3.8.6-eclipse-temurin-11 AS build
WORKDIR /app

# Copy pom.xml and resolve dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code and package the application
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage using Eclipse Temurin JRE 11
FROM eclipse-temurin:11-jre
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/app.jar app.jar

# Expose port 8080 (as specified in application.properties)
EXPOSE 8080

# Run the spring boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
