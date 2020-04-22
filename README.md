installation instructions:
1. download packages folder and replace gs-install-packages.sh file
2. load docker images by downloading tar files and running scripts/load-images.sh. (Alternative way: using docker hub - TBD)
3. add dns records to your dns server or add the following records to /etc/hosts file of the client machine that will browse the application: (assuming 192.168.1.240 is the ingress ip)
192.168.1.240 gensynth-api
192.168.1.240 gensynth
4. cd scripts
5. create-gensynth-ns.sh
6. set-gensynth-ns-context.sh
7. update values.yaml with desired values
8. helm-upgrade.sh
9. install-packages.sh

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
3. do steps 4-9 in installation instructions
4. browse to http://gensynth2
5. to get back to first instance of the application: set-job-index-null.sh
