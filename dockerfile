FROM openjdk:17
RUN mkdir /mc && mkdir /res
WORKDIR /mc
VOLUME "/mc"
# server port
EXPOSE 25565
# rcon port
EXPOSE 25575
COPY ./run/* ./config/* /res/
RUN addgroup --gid ${gid} ${username} && \
    adduser --uid ${uid} --ingroup ${username} --disabled-password ${username}
ENTRYPOINT ["/bin/bash", "/res/run.sh"]