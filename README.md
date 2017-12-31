# Docker化Jenkins（基于jenkins:2.60.3）

## 应用说明
- 参考《Using Docker》`jenkins:1.609.3`示例升级
- 初始化插件安装中仅加入`greenballs`新版本
- 时间设置时区本地化
- 参考docker官方`Debian`版安装指南，省略`buildpack-deps:curl`镜像重复步骤

## 安装及启动
### Jenkins容器安装要求
- 宿主机需要可以连接外部网络
- 宿主机需要已经安装Docker

### 安装及步骤方式
- 方式一.镜像下载
	- 通过如下命令从DockerHub直接获取镜像
	```
	docker pull nanquanyuhao/jenkins:release-2.60.3
	```
- 方式二.Dockerfile安装
	- 在项目子目录jenkins下，通过如下命令完成Jenkins容器镜像安装
	```
	cd jenkins2
	docker build -t nanquanyuhao/jenkins:release-2.60.3 .
	```
### Jenkins容器启动步骤
- 给启动脚本赋予执行权限
```
chmod +x jenkins_startup.sh
```
- 在jenkins目录下直接执行脚本完成容器启动
```
./jenkins_startup.sh
```
- 访问所在宿主机的8080端口即可访问Jenkins程序

## 添加Maven自定义配置文件
- 将settings.xml文件拷贝至启动后容器的个人目录下
- Jenkins启动后，配置Maven的个人配置文件为拷贝后文件的绝对路径即可