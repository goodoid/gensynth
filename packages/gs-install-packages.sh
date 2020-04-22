#!/bin/bash

set -e

POD=$(kubectl get pod -l app=gensynth-api -o jsonpath="{.items[0].metadata.name}")
echo ${POD}
kubectl cp ./packages/cifar10/ ${POD}:/gensynth/packages/
kubectl cp ./packages/simpnet-cifar10/ ${POD}:/gensynth/packages/
kubectl cp ./packages/simpnet-tutorial/ ${POD}:/gensynth/packages/
kubectl cp ./packages/sql-tool/ ${POD}:/gensynth/packages/
kubectl cp ./packages/basic-data-templates/ ${POD}:/gensynth/packages/
kubectl cp ./packages/resource-install ${POD}:/gensynth/packages/

kubectl exec ${POD} -- bash -c '
    set -e
    /gensynth/packages/resource-install /gensynth/packages --install simpnet-tutorial --force --verbose
    /gensynth/packages/resource-install /gensynth/packages --install basic-data-templates --force --verbose
    '
