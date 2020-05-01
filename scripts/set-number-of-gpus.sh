gpus=$1


if [[ -n "$gpus" ]]; then
    set -x
    # Change the path here 1    
    helm upgrade -i gensynth -n gensynth {path_to_gensynth_repo}/helm-chart/  --set jobIndex=${GENSYNTH_JOB_INDEX},numberOfGpus=$gpus
    kubectl delete replicaset -l app=gensynth-api -n gensynth

    set +x
    # wait for the pod to be allocated
    while [[ $(kubectl get pods -l app=gensynth-api -n gensynth -o go-template --template '{{range .items}}{{if eq (.status.phase) ("Pending")}}{{.metadata.name}} {{end}}{{if eq (.status.phase) ("Failed")}}{{.metadata.name}} {{end}}{{if eq (.status.phase) ("Unknown")}}{{.metadata.name}} {{end}}{{end}}') ]]; do
      if [[ "$TIMEOUT_COUNTER" -eq 30 ]]; then
        log_error "Aborting, pod took too long to start running."
        exit 1
      fi
      echo "Not all pods are running"
      TIMEOUT_COUNTER=$((TIMEOUT_COUNTER+1))
      sleep 2
    done

    set -x
    # Change the path here 2
    {path_to_gensynth_packages_directory}/gs-install-packages.sh


else
    echo "missing number of gpus as an argument"
fi
