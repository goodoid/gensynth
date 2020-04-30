gpus=$1


if [[ -n "$gpus" ]]; then
    set -x	
    helm upgrade -i gensynth  ../helm-chart/  --set jobIndex=${GENSYNTH_JOB_INDEX},numberOfGpus=$gpus
    kubectl delete pod -l app=gensynth-api -n gensynth
else
    echo "missing number of gpus as an argument"
fi
