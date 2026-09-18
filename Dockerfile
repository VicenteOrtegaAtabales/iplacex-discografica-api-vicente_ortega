# STAGE 1
FROM gradle:jdk21 as builder

WORKDIR /app

COPY ./build.gradle .
COPY ./settings.gradle .

COPY src ./src

RUN gradle build --no-daemond

# STAGE 2
FROM openjdk:21-jdk-slim

WORKDIR /app

COPY --from=builder /app/build/libs/*.war discografia.war

EXPOSE 8080

CMD ["java", "-jar", "discografia.war"] 