FROM openjdk:8
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
RUN mkdir /minecraft
WORKDIR /minecraft
EXPOSE 25565
EXPOSE 25575
CMD ./run.sh