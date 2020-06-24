#!/bin/sh
set -x
helm upgrade -i gensynth  ../helm-chart/  --set jobIndex=${GENSYNTH_JOB_INDEX} -f values.yaml $@
