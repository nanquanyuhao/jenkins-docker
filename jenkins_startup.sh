#! /bin/bash

set -e

if docker ps -a | grep -i jenkins-environment ; then
	docker rm -vf jenkins-environment
fi

if docker ps -a | grep -i jenkins-datacontainer ; then
	echo 'Jenkins Data Container Exists'
else
	docker run --name jenkins-datacontainer nanquanyuhao/jenkins:release-2.60.3 echo "Jenkins Data Container"
fi

docker run -d --name jenkins-environment -p 8080:8080 --volumes-from jenkins-datacontainer -v /var/run/docker.sock:/var/run/docker.sock nanquanyuhao/jenkins:release-2.60.3