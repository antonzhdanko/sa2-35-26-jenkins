# Jenkins image and Helm chart

This repository contains the custom Jenkins controller image and Helm chart for
the IT Academy Kubernetes application deployment homework.

The image is published by GitHub Actions to:

```text
jfrog.it-academy.by/public/jenkins-ci:antonzhdanko
```

The JFrog password is stored only as the `JFROG_PASS` GitHub Actions secret. It
is not present in this repository.
