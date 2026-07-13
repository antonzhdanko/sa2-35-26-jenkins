# Jenkins image and Helm chart

This repository contains the custom Jenkins controller image and Helm chart for
the IT Academy Kubernetes application deployment homework.

The image is published by GitHub Actions to:

```text
jfrog.it-academy.by/public/jenkins-ci:antonzhdanko
```

The JFrog password is stored only as the `JFROG_PASS` GitHub Actions secret. It
is not present in this repository.

## Helm repository

```bash
helm repo add anton-jenkins https://antonzhdanko.github.io/sa2-35-26-jenkins/
helm repo update
```

Create the administrator password as a Kubernetes Secret. Do not put the
password into a values file or Git repository:

```bash
kubectl create namespace ci-cd --dry-run=client -o yaml | kubectl apply -f -
kubectl create secret generic jenkins-admin \
  --namespace ci-cd \
  --from-literal=password='CHANGE_ME'
```

Install Jenkins with the homework defaults:

```bash
helm upgrade --install jenkins anton-jenkins/jenkins-homework \
  --version 0.1.0 \
  --namespace ci-cd \
  --create-namespace \
  --set admin.username=admin \
  --set jenkins.url=http://jenkins.k8s-3.sa/ \
  --set persistence.storageClass=local-path \
  --set persistence.size=5Gi \
  --wait --timeout 15m
```

The default values are documented in
[`chart/jenkins-homework/values.yaml`](chart/jenkins-homework/values.yaml). All
deployment-specific settings, including the image, resources, storage, service,
Jenkins URL and Istio hosts, can be overridden there or with `--set`.

## Local chart checks

```bash
helm lint chart/jenkins-homework
helm template jenkins chart/jenkins-homework --namespace ci-cd
```
