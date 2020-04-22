#!/bin/sh
set -x
kubectl delete ns gensynth${GENSYNTH_JOB_INDEX}
