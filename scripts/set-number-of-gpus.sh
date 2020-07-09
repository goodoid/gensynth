runai project set gensynth

cd `dirname "$0"`/..



gpus=$1


if [[ -n "$gpus" ]]; then
    set -x
    kubectl get cm api-config -o yaml | sed -e 's|"gensynth": .|"gensynth": '"$gpus"'|' | kubectl apply -f -
    kubectl set resources deployment gensynth-api --limits=nvidia.com/gpu=$gpus
    kubectl delete replicaset -l app=gensynth-api

    set +x
    # wait for the pod to be allocated
    while [[ $(kubectl get pods -l app=gensynth-api -o go-template --template '{{range .items}}{{if eq (.status.phase) ("Pending")}}{{.metadata.name}} {{end}}{{if eq (.status.phase) ("Failed")}}{{.metadata.name}} {{end}}{{if eq (.status.phase) ("Unknown")}}{{.metadata.name}} {{end}}{{end}}') ]]; do
      if [[ "$TIMEOUT_COUNTER" -eq 30 ]]; then
        echo "Aborting, pod took too long to start running."
        exit 1
      fi
      echo "Not all pods are running"
      TIMEOUT_COUNTER=$((TIMEOUT_COUNTER+1))
      sleep 2
    done

    set -x
    # Change the path here 2
    packages/gs-install-packages.sh

else
    echo "missing number of gpus as an argument"
fi
