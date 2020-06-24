#!/bin/sh
set -x
kubectl get secret gcr-secret -n runai -oyaml | grep -v '^\s*namespace:\s' | kubectl apply -f -
