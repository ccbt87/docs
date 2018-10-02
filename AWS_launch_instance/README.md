# Prerequisites
AWS account with sufficient authorization

# 1. Launch Instance
1. Sign In to the AWS Management Console
2. Go to `Services` -> `EC2`
![EC2](images/1.2.0.PNG)
3. Click `Launch Instance`
![Launch Instance](images/1.3.0.PNG)
    1. `Select` desired Operating System.
      * RHEL and SLES are more expensive than other Linux such as CentOS and Ubuntu.
    ![Choose AMI](images/1.3.1.PNG)
    2. Choose an desired Instance Type. Click `Next: Configure Instance Details`
    ![Choose Instance](images/1.3.2.PNG)
    3. Set desired `Number of instances` and `Subnet`. Click `Next: Add Storage`
    ![Configure Instance](images/1.3.3.PNG)
    4. Set desired Storage size and type. Click `Next: Add Tags`
    ![Add Storage](images/1.3.4.PNG)
    5. Skip adding tags. Click `Next: Configure Security Group`
    ![Add Tags](images/1.3.5.PNG)
    6. Create a desired security group or select an existing security group. Click `Review and Launch`
    ![Configure Security Group](images/1.3.6.PNG)
    7. Review and click `Launch`
    ![Review](images/1.3.7.PNG)
    8. Select an existing key pair or create a new key pair. Check the checkbox and click `Launch Instance`
    ![Key](images/1.3.8.PNG)

# 2. View Instance(s)
Click `View Instance` or go to `Services` -> `EC2` -> `Instances`.
![View Instance](images/2.0.0.PNG)

# What you can do next
* Deploy a HDP/HDF cluster https://github.com/ccbt87/docs/tree/master/AWS_deploy_HDP_HDF_cluster_using_Ambari
* Deploy a Cassandra cluster
