FROM openjdk:8-jdk

MAINTAINER zsx <zhong.sixian@trans-cosmos.com.cn>

RUN set -x && \
    apt-get update && DEBIAN_FRONTEND=nointeractive apt-get install -y --no-install-recommends \
      apt-transport-https &&\
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && DEBIAN_FRONTEND=nointeractive apt-get install -y --no-install-recommends \
      kubectl=1.11.5-00 \
      vim

RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash

RUN mkdir ~/.kube/
