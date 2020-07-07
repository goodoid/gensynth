**Run:AI and GenSynth Integration**

_**Installation Instructions:**_
1. Create a Project in Run:Ai with name of `gensynth` with the number of GPUs that will be used by the application.
2. Set gensynth project context in runai cli

    `runai project set gensynth`

3. Clone this repository.
4. Create a directory for the storage on the node, the directory should have an internal directory called "workspace-storage" with all permissions - this directory will be used by the API image. `mkdir –m777 {path}/workspace-storage`
5. Access to Docker images for the deployments:
    
    - Option 1: Use Gensynth docker repository:

       - a. run script `create-gensynth-docker-repository-credentials.sh <username> <password>` with credentials that have access to Gensynth docker repository.
    
       - b. update values.yaml with the following values:

          - `imagePullSecrets: gensynth-docker-repository-credentials`
         
          - `gensynthApiImage: darwinai/gensynth:api_1.10.0-gpu`
 
          - `gensynthDbImage: darwinai/gensynth-db:1.10.0-pg`

          - `gensynthWebImage: darwinai/gensynth-web:1.10.0`
       
    - Option 2: Use Runai docker repository:
    
       - a. run script `create-runai-secret.sh`.
       
       - b. update values.yaml with the following values:

          - `imagePullSecrets: gcr-secret`

          - `gensynthApiImage: gcr.io/run-ai-prod/gensynth:api_1.8.0-gpu`

          - `gensynthDbImage: gcr.io/run-ai-prod/gensynth-db:1.8.0-pg`

          - `gensynthWebImage: gcr.io/run-ai-prod/gensynth-web:1.8.0`
    
6. Set the values file in the helm-charts with the relevant configuration.
7. If want to configure other load balancer port than the default 80, need to do the following (for example port 81):

   a. `kubectl edit runaiconfig -n runai`

   b. Add the following configuration under `spec:`
    ```
      nginx-ingress:
        controller:
          service:
            ports:
              http: 81
    ```

   c. Wait and verify until `kubectl get svc -n runai | grep LoadBalancer` shows port 81. should be something like this: `81:30322/TCP,443:32301/TCP` 

   d. Add to values file: `port: 81`

8. Run the helm install script to deploy the application: `helm-upgrade.sh`
9. Verify all pods are allocated and running.
10. Download packages folder
12. Replace gs-install-packages.sh file: cp packages-override/gs-install-packages.sh packages
13. Run `install-packages.sh`
14. Add the DNS records to your DNS. Run `kubectl get service` - the external of GenSynth Application should be added to the DNS.

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
