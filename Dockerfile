FROM jenkins/jenkins:lts-jdk21

LABEL org.opencontainers.image.authors="antonzhdanko@gmail.com"
LABEL org.opencontainers.image.source="https://github.com/antonzhdanko/sa2-35-26-jenkins"

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

USER root

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        ansible \
        ca-certificates \
        curl \
        git \
        jq \
        openssh-client \
        wget \
    && rm -rf /var/lib/apt/lists/*

USER jenkins
