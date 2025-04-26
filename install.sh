#!/bin/sh

if [ $# != 3 ] ; then 
echo "USAGE: sh install.sh k8s主节点IP地址 kuboard密钥 项目命名空间" 
  echo " e.g.: sh install.sh 172.20.41.58 ejxxxxx its" 
  exit 1; 
fi

K8S_IP=$1
KUBOARD_TOKEN=$2
NAMESPACE=$3

#安装jdk
rpm -ivh jdk-8u221-linux-x64.rpm

ARGS="--kubernetes.deploy.ip=$K8S_IP --kubernetes.deploy.token=$KUBOARD_TOKEN --kubernetes.deploy.namespace=$NAMESPACE --kubernetes.deploy.harbor-ip=docker-registry.supconit.com"

sed -i "s/JAVA_OPTS/$JAVA_OPTS/g" deploy.service
cp ./start-deploy.sh /usr/local/bin/
chmod a+x /usr/local/bin/start-deploy.sh
sed -i "s/ARGS/$ARGS/g" /usr/local/bin/start-deploy.sh
cp ./k8s-deploy.jar /usr/local/bin/k8s-deploy.jar
cp ./deploy.service /usr/lib/systemd/system/deploy.service
systemctl enable deploy.service
systemctl start deploy.service