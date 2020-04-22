installation instructions:
1. download packages folder
2. replace gs-install-packages.sh file: cp packages-override/gs-install-packages.sh packages
3. load docker images by downloading tar files and running scripts/load-images.sh. (Alternative way: using docker hub - TBD)
4. add dns records to your dns server or add the following records to /etc/hosts file of the client machine that will browse the application: (assuming 192.168.1.240 is the ingress ip)
192.168.1.240 gensynth-api
192.168.1.240 gensynth
5. cd scripts
6. create-gensynth-ns.sh
7. set-gensynth-ns-context.sh
8. create values.yaml file in same format as values-example.yaml and update desired values
9. helm-upgrade.sh
10. wait until all pods are running
11. install-packages.sh

test application works:
1. browse to http://gensynth
2. enter username: administrator, password: Password123
3. go to Entities, Dataset. go to first dropdown "Load an existing entity". make sure you see some items there (first item is "Basic Dataset Template").
4. run a test job by following screenshots in screenshots-for-running-test-job folder 

cleanup:
1. helm-delete.sh

running another instance of the application:
1. add the following records to dns server or to /etc/hosts:
192.168.1.240 gensynth-api2
192.168.1.240 gensynth2
2. set-job-index-2.sh
3. do steps 5-11 in installation instructions
4. browse to http://gensynth2
5. to get back to first instance of the application: set-job-index-null.sh
