FROM amazoncorretto:21-alpine-jdk
RUN mkdir /mc && mkdir /res
RUN apk update && apk add screen
WORKDIR /mc
VOLUME "/mc"
# server port
EXPOSE 25565
# rcon port
EXPOSE 25575
COPY ./run/* ./config/* /res/
ENTRYPOINT ["/bin/ash", "/res/run.sh"]