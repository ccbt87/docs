# Prerequisites
AWS account with sufficient authorization

# 1. Launch Instance
1. Sign In to the AWS Management Console
2. Go to `Services` -> `EC2`
![EC2](images/1.2.0.png)
3. Click `Launch Instance`
![Launch Instance](images/1.3.0.png)
    1. `Select` Red Hat Enterprise Linux 7.5 (HVM), SSD Volume Type - ami-28e07e50
    ![Choose AMI](images/1.3.1.png)
    2. Choose an desired Instance Type. Click `Next: Configure Instance Details`
    ![Choose Instance](images/1.3.2.png)
    3. Set desired `Number of instances` and `Subnet`. Click `Next: Add Storage`
    ![Configure Instance](images/1.3.3.png)
    4. Set desired Storage size and type. Click `Next: Add Tags`
    ![Add Storage](images/1.3.4.png)
    5. Skip adding tags. Click `Next: Configure Security Group`
    ![Add Tags](images/1.3.5.png)
    6. Create a desired security group or select an existing security group. Click `Review and Launch`
    ![Configure Security Group](images/1.3.6.png)
    7. Review and click `Launch`
    ![Review](images/1.3.7.png)
    8. Select an existing key pair or create a new key pair. Check the checkbox and click `Launch Instance`
    ![Key](images/1.3.8.png)

# 2. View Instance(s)
Click `View Instance` or go to `Services` -> `EC2` -> `Instances`.
![View Instance](images/2.0.0.png)

# What you can do next
* Deploy a HDP/HDF cluster
* Deploy a Cassandra cluster
