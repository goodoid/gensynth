**Run:AI and GenSynth Integration**

_**Installation Instructions:**_
1. Create a Project in Run:Ai with name of `gensynth` with the number of GPUs that will be used by the application.
2. Set gensynth project context in runai cli

    `runai project set gensynth`

3. Clone this repository.
4. Create a directory for the storage on the node, the directory should have an internal directory called "workspace-storage" with all permissions - this directory will be used by the API image. `mkdir –m777 {path}/workspace-storage`
5. Access to Docker images for the deployments:
    
    _Option 1:_ Give the deployments access to Darwin docker repository:_ 
    
    a. Create a Secret based on existing Docker credentials -  https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
    
    b. Set the `imagePullSecrets` and `image` of all 3 deployments.
    
    _Option 2: Use runai private repository:_ 
    
    a. Run the script: `create-runai-secret.sh`.
    
6. Set the values file in the helm-charts with the relevant configuration.
7. Run the helm install script to deploy the application: `helm-upgrade.sh`
8. Verify all pods are allocated and running.
9. Go to the GenSynth's root Github directory, and run `packages/gs-install-packages.sh` - this will load and install all the packages to the API pod.  
10. Add the DNS records to your DNS. Run `kubectl get service` - the external of GenSynth Application should be added to the DNS.

    <br/>
    <br/>
    <br/>
    <br/>
    <br/>


**Test the application works:**
1. Browse to http://gensynthin
2. Enter username: administrator, password: Password123
3. Go to Entities, Dataset. go to first dropdown "Load an existing entity". make sure you see some items there (first item is "Basic Dataset Template").
4. Run a test job by following screenshots in screenshots-for-running-test-job folder 

**Cleanup:**
1. `helm-delete.sh`

**How to run another instance of the application:**
1. add the following records to dns server or to /etc/hosts:
192.168.1.240 gensynth-api2
192.168.1.240 gensynth2
2. `set-job-index-2.sh`
3. do steps 2-11 in installation instructions
4. browse to http://gensynth2
5. to get back to first instance of the application: `set-job-index-null.sh`
