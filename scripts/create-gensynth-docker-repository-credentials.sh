#!/bin/sh
set -x
kubectl create secret docker-registry gensynth-docker-repository-credentials --docker-server=https://index.docker.io/v1/ --docker-username=$1 --docker-password=$2

