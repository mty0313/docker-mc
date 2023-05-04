# Minecraft in Docker

## 快速开始

```
# 原版 1.19.4

docker run -d \
   --name vanilla1194 \
   --restart=unless-stopped \
   -p 25565:25565 \
   -v $HOME/vanilla1194:/mc \
   martin0313/docker-mc:vanilla1194

# mohist 1.12.2

docker run -d \
   --name mohist1122 \
   --restart=unless-stopped \
   -p 25565:25565 \
   -v $HOME/mohist1122:/mc \
   martin0313/docker-mc:mohist1122
```

## 这个项目是什么

我做了一些整理工作, 基于openjdk打包了几个镜像, 只需要简单的执行一条 `docker run` 即可运行自己的服务器, 旨在尽可能简化Minecraft的开服过程. 

- 预设有: 原版服 1.19.4, mod服 1.12.2


## 其他

如果docker拉取镜像遇到困难, 可以将本项目拉到本地构建镜像并运行. 

## 链接

[Github地址](https://github.com/mty0313/docker-mc)

[DockerHub地址](https://hub.docker.com/r/martin0313/docker-mc)

[Minecraft Server](https://www.minecraft.net/zh-hans/download/server)

[Mohist Server](https://mohistmc.com/)
