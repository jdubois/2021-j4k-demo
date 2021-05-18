
FROM openjdk:11-jdk-alpine as build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw package -Pprod -DskipTests | egrep -v "(^\[INFO\])"
COPY /target/ /target/

FROM openjdk:11-jdk-alpine
VOLUME /tmp
COPY --from=build /target/ /target/
ENTRYPOINT ["java -noverify -XX:+AlwaysPreTouch com.microsoft.devrel.j4kdemo.J4KdemoApp"]
