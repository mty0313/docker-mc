# Minecraft in Docker

## 快速开始

```
# arclight fabric 1.20.4

docker run -d \
   --name fabric1204 \
   --restart=unless-stopped \
   -p 25565:25565 \
   -v $HOME/fabric1204:/mc \
   martin0313/docker-mc:fabric1204

# 原版 1.19.4

docker run -d \
   --name vanilla1194 \
   --restart=unless-stopped \
   -p 25565:25565 \
   -v $HOME/vanilla1194:/mc \
   martin0313/docker-mc:vanilla1194
   
# mohist 1.16.5

docker run -d \
   --name mohist1165 \
   --restart=unless-stopped \
   -p 25565:25565 \
   -v $HOME/mohist1165:/mc \
   martin0313/docker-mc:mohist1165

# mohist 1.12.2

docker run -d \
   --name mohist1122 \
   --restart=unless-stopped \
   -p 25565:25565 \
   -v $HOME/mohist1122:/mc \
   martin0313/docker-mc:mohist1122

# forge 1.20.1

docker run -d \
   --name forge1201 \
   --restart=unless-stopped \
   -p 25565:25565 \
   -p 25575:25575 \
   -v $HOME/forge1201:/mc \
   -e USER_ID=$(id -u) \
   -e GROUP_ID=$(id -g) \
   martin0313/docker-mc:forge1201
```

## 这个项目是什么

我做了一些整理工作, 基于openjdk打包了几个镜像, 只需要简单的执行一条 `docker run` 即可运行自己的服务器, 旨在尽可能简化Minecraft的开服过程. 

- 预设有: 原版服 1.19.4, mod服 1.16.5, mod服 1.12.2, forge 1.20.1


## 其他

如果docker拉取镜像遇到困难, 可以将本项目拉到本地构建镜像并运行. 

### 构建自定义 Forge 服务器镜像

如果需要构建自定义的 Forge 服务器镜像，请按照以下步骤操作：

#### step1

java -jar /root/docker-mc/tmp/forge-1.20.1-47.4.10-installer.jar --installServer /root/docker-mc/forge-server

#### step2

运行forge-server中的run.sh, 生成文件

#### step3

rm -rf forge-server/world

#### step4

构建docker镜像

```bash
# 获取当前用户ID和组ID
USER_ID=$(id -u)
GROUP_ID=$(id -g)

# 构建镜像
docker build --build-arg USER_ID=$USER_ID --build-arg GROUP_ID=$GROUP_ID -t martin0313/docker-mc:forge1201 .
```

## 链接

[Github地址](https://github.com/mty0313/docker-mc)

[DockerHub地址](https://hub.docker.com/r/martin0313/docker-mc)

[Minecraft Server](https://www.minecraft.net/zh-hans/download/server)

[Mohist Server](https://mohistmc.com/)
