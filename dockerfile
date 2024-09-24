FROM openjdk:21
RUN mkdir /mc && mkdir /res
WORKDIR /mc
VOLUME "/mc"
# server port
EXPOSE 25565
# rcon port
EXPOSE 25575
COPY ./run/* ./config/* /res/
ENTRYPOINT ["/bin/bash", "/res/run.sh"]