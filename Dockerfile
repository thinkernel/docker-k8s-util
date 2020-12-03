FROM buildpack-deps:buster

MAINTAINER zsx <thinkernel@gmail.com>

# Set current dir
WORKDIR /root

# Install vim
RUN apt-get update && apt-get install -y --no-install-recommends \
		vim \
	&& rm -rf /var/lib/apt/lists/*

# Install aws cli
RUN set -x && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Install aws-iam-authenticator
RUN set -x && \
    curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x ./aws-iam-authenticator && \
    mv ./aws-iam-authenticator /usr/local/bin

# Install eksctl
ENV EKSCTL_VERSION=0.33.0-rc.0
RUN set -x && \
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/${EKSCTL_VERSION}/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp && \
    mv /tmp/eksctl /usr/local/bin

# Install kubectl
RUN set -x && \
    curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.12/2020-11-02/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin

ENV DESIRED_VERSION=v3.3.4
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# terraform
ENV TF_VERSION=0.13.0
RUN curl -fSsL \
    https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip \
    -o /tmp/terraform.zip && \
    unzip /tmp/terraform.zip -d /usr/local/sbin && \
    rm /tmp/terraform.zip

