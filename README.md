# Minecraft in Docker

## 这个项目是什么

我做了一些整理工作, 只需要简单的执行一条 `docker run` 即可运行自己的服务器, 预设有原版1.19.4, mod服1.12.2

## 快速开始(原版服务器)

1. 安装Docker(如已安装跳过)
	
	在ubuntu上安装docker只需要输入如下命令:

	```
	sudo apt update
	sudo apt install -y docker.io
	```

2. 映射出你的配置文件(可选,但是推荐)
	
	这一步映射容器中的配置文件到宿主机, 如果不做这一步, 你的服务器修改配置会比较麻烦. (默认配置使用25565端口, 默认开启正版验证等)

	按照如下步骤映射出配置文件:

	```
	mkdir ~/vanilla1194-config && cd ~/vanilla1194-config

	curl -o server.properties https://gitee.com/mty0313/docker-mc/raw/master/config/server.properties
	```

	这里的配置默认已经关闭了正版验证, 其他保持默认的官方1.19.4原版配置.

3. 启动服务器
	
	确保你在刚才创建的`vanilla1194-config`文件夹下, 运行如下命令即可

	```
	docker run -d \
    --name vanilla1194 \
    --restart=unless-stopped \
    -p 25565:25565 \
    -v $(pwd)/server.properties:/mc/server.properties \
    martin0313/docker-mc:vanilla1194
	```