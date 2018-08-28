## Architecture
![Architecture](/images/cda-architecture.jpg)

## Prerequisites
* Docker version 17.09 or newer installed
* At least 12 GB memory

## Deployment
1. Configure memory for Windows or MacOS (No special configuration needed for Linux). Steps can be found at https://hortonworks.com/tutorial/sandbox-deployment-and-install-guide/section/3/
2. Load the Docker images from local files
    * `docker load -i path-to-file/sandbox-hdp_2.6.5`
    * `docker load -i path-to-file/sandbox-hdf_3.1.1`
    * `docker load -i path-to-file/sandbox-proxy_1.0`
3. Download the deploy script `HDP_2.6.5_deploy-scripts_180624d542a25.zip` or `HDF_3.1.1_deploy-scripts_180624d542a25.zip` (only one of the two needed) from the Hortonworks website or from this repository. Unzip the zip file.
4. Run the script `docker-deploy-{version}.sh` for HDP or HDF.
5. After the previous script is done, run the script `enable-native-cda.sh`.

## Access the HDP and HDF
To access the HDP and HDF, visit

## Reference
* Deploying Hortonworks Sandbox on Docker and Troubleshooting https://hortonworks.com/tutorial/sandbox-deployment-and-install-guide/section/3/
