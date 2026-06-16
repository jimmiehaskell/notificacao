FROM gradle:jdk21-corretto as build
WORKDIR /app
COPY . .
RUN gradle build --no-daemon

FROM amazoncorretto:21-alpine-jdk
LABEL authors="Jimmie Haskell"
WORKDIR /app
COPY --from=build /app/build/libs/*.jar /app/notificacao.jar
EXPOSE 8082
CMD ["java", "-jar", "/app/notificacao.jar"]