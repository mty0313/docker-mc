# Minecraft in Docker

如果你看到标题就知道我在说什么, 那么下面给出docker-cli:

```
# 拉取1.19.4默认的配置文件
curl -o $(pwd)/server.properties https://gitee.com/mty0313/docker-mc/raw/master/config/server.properties

# 原版 1.19.4
docker run -d \
    --name vanilla1194 \
    --restart=unless-stopped \
    -p 25565:25565 \
    -v $(pwd)/server.properties:/mc/server.properties \
    martin0313/docker-mc:vanilla1194

# 拉取mohist 1.12.2 的默认配置文件
curl -o $(pwd)/server.properties https://gitee.com/mty0313/docker-mc/raw/mohist1122/config/server.properties

# mohist 1.12.2
docker run -d \
    --name mohist1122 \
    --restart=unless-stopped \
    -p 25565:25565 \
    -v $(pwd)/server.properties:/mc/server.properties \
	-v 
    martin0313/docker-mc:mohist1122
```

然后你可以关闭文章并开始游戏. 如果想了解更多, 也可以继续往下阅读.

## 这个项目是什么

我做了一些整理工作, 打包了几个镜像, 只需要简单的执行一条 `docker run` 即可运行自己的服务器. 

- 预设有: 原版服 1.19.4, mod服 1.12.2

## 快速开始(原版服务器1.19.4)

1. 安装Docker(如已安装跳过)
	
	在ubuntu上安装docker只需要输入如下命令:

	```
	sudo apt update
	sudo apt install -y docker.io
	```

2. 创建服务端配置文件用于映射(可选,但是推荐)
	
	这一步映射容器中的配置文件到宿主机, 如果不做这一步, 你的服务器修改配置会比较麻烦. (默认配置使用25565端口, 默认开启正版验证等)

	按照如下步骤映射出配置文件:

	```
	mkdir ~/vanilla1194-config && cd ~/vanilla1194-config

	curl -o server.properties https://gitee.com/mty0313/docker-mc/raw/master/config/server.properties
	```

	这里的配置默认已经关闭了正版验证, 其他保持默认的官方1.19.4原版配置.

3. 启动服务器
	
	确保你在刚才创建的`vanilla1194-config`文件夹下, 运行如下命令

	```
	docker run -d \
	--name vanilla1194 \
	--restart=unless-stopped \
	-p 25565:25565 \
	-v $(pwd)/server.properties:/mc/server.properties \
	martin0313/docker-mc:vanilla1194
	```

	这样你的服务端就启动了. 多人游戏中填入你的 ip:port 愉快联机吧

## 快速开始(Mod服1.12.2)

1. 安装Docker(如已安装跳过)
	
	在ubuntu上安装docker只需要输入如下命令:

	```
	sudo apt update
	sudo apt install -y docker.io
	```

2. 创建服务端配置文件用于映射(可选,但是推荐)
	
	这一步映射容器中的配置文件到宿主机, 如果不做这一步, 你的服务器修改配置会比较麻烦. (默认配置使用25565端口, 默认开启正版验证等)

	按照如下步骤映射出配置文件:

	```
	mkdir ~/mohist1122-config && cd ~/mohist1122-config

	curl -o server.properties https://gitee.com/mty0313/docker-mc/raw/mohist1122/config/server.properties
	```

	这里的配置默认已经关闭了正版验证, 其他保持默认的mohist 1.12.2配置.

3. 创建宿主机的插件、Mod文件夹用于映射(可选,但是推荐)

	确保你在刚才创建的`mohist1122-config`文件夹下, 运行如下命令

	```
	mkdir mods && mkdir plugins
	```

	如果不创建文件夹, docker运行时也会自动创建, 现在你可以把mod和plugin放到对应的文件夹中.

4. 启动服务器
	
	确保你在刚才创建的`mohist1122-config`文件夹下, 运行如下命令

	```
	docker run -d \
	--name mohist1122 \
	--restart=unless-stopped \
	-p 25565:25565 \
	-v $(pwd)/server.properties:/mc/server.properties \
	-v $(pwd)/mods:/mc/mods \
	-v $(pwd)/plugins:/mc/plugins \
	martin0313/docker-mc:mohist1122
	```

	这样你的服务端就启动了. 多人游戏中填入你的 ip:port 愉快联机吧

## 如果遇到问题

原版服务器执行`docker logs -f vanilla1194`, Mod服执行`docker logs -f mohist1122` 查看日志.

## 链接

[Minecraft Server](https://www.minecraft.net/zh-hans/download/server)

[Mohist Server](https://mohistmc.com/)