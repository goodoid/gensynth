#!/bin/sh
set -x
helm upgrade -i gensynth  ../helm-chart/ -f values.yaml --set jobIndex=${GENSYNTH_JOB_INDEX} $@
