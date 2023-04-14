FROM openjdk:17
RUN groupadd -g 1000 ubuntu && useradd ubuntu -u 1000 -g 1000 && mkdir /mc && mkdir /res
RUN chown -R ubuntu /mc && chown -R ubuntu /res && \
    chgrp -R ubuntu /mc && chgrp -R ubuntu /res && \
    chmod -R 755 /mc && chmod -R 755 /res
WORKDIR /mc
# server port
EXPOSE 25565
# rcon port
EXPOSE 25575
COPY ./run/* ./config/* /res/
USER ubuntu
ENTRYPOINT ["/bin/bash", "/res/run.sh"]