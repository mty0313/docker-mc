FROM openjdk:8
# RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# RUN echo 'Asia/Shanghai' >/etc/timezone
RUN mkdir /mc
WORKDIR /mc
# server port
EXPOSE 25565
# rcon port
# EXPOSE 25575
COPY ./run/mohist.jar /mc/mohist.jar
RUN echo "eula=true" > eula.txt
CMD ["java", "-jar", "-Xmx2048M", "-Xms512M", "mohist.jar"]