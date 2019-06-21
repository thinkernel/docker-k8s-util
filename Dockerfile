FROM openjdk:8-jdk

MAINTAINER zsx <thinkernel@gmail.com>

RUN set -x && \
    apt-get update && DEBIAN_FRONTEND=nointeractive apt-get install -y --no-install-recommends \
      apt-transport-https &&\
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && DEBIAN_FRONTEND=nointeractive apt-get install -y --no-install-recommends \
      kubectl=1.11.5-00 \
      vim

ENV DESIRED_VERSION=v2.11.0
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash

# terraform
ENV TF_VERSION=0.11.14
RUN curl -fSsL \
    https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip \
    -o /tmp/terraform.zip && \
    unzip /tmp/terraform.zip -d /usr/local/sbin && \
    rm /tmp/terraform.zip

RUN mkdir ~/.kube/
