#!/bin/sh
set -x
kubectl config set-context --current --namespace=gensynth${GENSYNTH_JOB_INDEX}
