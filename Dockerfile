FROM jenkins:2.60.3
MAINTAINER nanquanyuhao <nanquanyuhao@foxmail.com>

ENV TIME_ZONE Asia/Shanghai
ENV DOCKER_COMPOSE_VERSION 1.18.0

USER root
RUN echo "${TIME_ZONE}" > /etc/timezone \ 
	&& ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime

RUN apt-get update \
      && apt-get install -y apt-transport-https \
      && apt-get install -y gnupg2 \
      && apt-get install -y software-properties-common \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
      && apt-key fingerprint 0EBFCD88 \
      && add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) stable"

RUN apt-get update \
      && apt-get install -y docker-ce \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/\
docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose; \
    chmod +x /usr/local/bin/docker-compose

USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/plugins.txt | tr '\n' ' ')