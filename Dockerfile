# Use the latest OpenJDK image (slim version for efficiency)
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /usr/src/myapp

# Copy all the files from your local project directory to the container
COPY . .

# Ensure that the Maven wrapper (mvnw) is executable
RUN chmod +x mvnw

# Build the project using Maven wrapper
RUN ./mvnw clean package -DskipTests

# Set the default command to run the application using the Maven wrapper with the cargo plugin for Tomcat 9
CMD ["./mvnw", "cargo:run", "-P", "tomcat90"]
