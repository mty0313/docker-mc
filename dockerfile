FROM docker.1ms.run/amazoncorretto:17-alpine-jdk

RUN mkdir /mc /original_files
WORKDIR /mc
VOLUME "/mc"
# server port
EXPOSE 25565
# rcon port
EXPOSE 25575
COPY ./forge-server/ /original_files/

# Copy entrypoint script that handles dynamic user setup
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]