# Usa una imagen base de OpenJDK 17.
FROM eclipse-temurin:17-jdk-alpine

# Establece el directorio de trabajo dentro del contenedor.
WORKDIR /app

# Copia los archivos del Maven Wrapper y el pom.xml.
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Descarga las dependencias de Maven.
RUN ./mvnw dependency:go-offline -B

# Copia el resto del código fuente de la aplicación.
COPY src src

# Construye la aplicación Spring Boot en un JAR ejecutable.
RUN ./mvnw package -DskipTests

# Expone el puerto en el que la aplicación Spring Boot escuchará (8080 por defecto).
EXPOSE 8080

# Define el comando para ejecutar la aplicación JAR.
CMD sh -c 'java -jar target/*.jar'


