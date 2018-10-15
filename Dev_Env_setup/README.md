# Spark Development Environment Setup with Java and Maven

## Prerequisites
* Installed JDK
* Installed IntelliJ IDEA
* Installed Maven (Bundled Maven comes with the IDEA)
* Installed Docker

## Creating IntelliJ Project
NOTE: Instructions may vary. This tutorial uses IntelliJ Version: 2018.2.4 on Windows 10 1803.

Create a new project by selecting File > New > Project, or Create New Project on the IntelliJ IDEA Welcome window. Then select Maven, set JDK version and click Next.

![New](images/1.1.PNG)

Specify the GroupId, ArtifactId and Version, then click Next.

![Id](images/1.2.PNG)

Name the project and select location, then click Finish.

![Name](images/1.3.PNG)

IntelliJ should make a new project with a default directory structure.

![Project](images/1.4.PNG)

## Change IntelliJ Settings

To different Maven version, go to File > Settings > Build, Execution, Deployment > Build Tools > Maven. Change the Maven home directory.

![Maven](images/2.1.PNG)

Go to File > Settings > Build, Execution, Deployment > Build Tools > Maven > Importing. Verify that `import Maven projects automatically` is Checked.

![Import](images/2.2.PNG)

Go to File > Project Structure > Project. Verify Project SDK and Project language level are set to Java version.

![SDK](images/2.3.PNG)

Go to File > Project Structure > Modules. Verify Language level is set to Java version.

![Level](images/2.4.PNG)

## Import Libraries and Write Code

Open the pom.xml file in the project directory.

For demo purpose, copy everything from https://github.com/ccbt87/sample-KafkaSparkHBase/blob/master/pom.xml to it.

![POM](images/3.1.PNG)

Select the folder `src/main/java` in the project directory. Right-click on folder and select New > Java Class. Name the class: KafkaSparkHBase.java

![Class](images/4.1.PNG)

For demo purpose, copy everything from https://github.com/ccbt87/sample-KafkaSparkHBase/blob/master/src/main/java/KafkaSparkHBase.java to it.

![Code](images/4.2.PNG)

NOTE: Do not worry about the red lines for now.

## Setup Test Environment
Pull the Docker image https://hub.docker.com/r/ccbt87/aio/
```
docker pull ccbt87/aio
```
Run the image (specify the hostname and the name for the container as needed)
```
docker run --hostname aio --name aio -it ccbt87/aio
```
For demo purpose, this tutorial use `aio` for both names.

## Create jar and Deploy to the Test Environment

Go to Maven Projects > {Project Name} > Lifecycle. Double click on package. This will create a compiled jar under target in the project directory.

![JAR](images/6.1.PNG)

NOTE: The red lines should disappear after you close and reopen the IntelliJ IDEA.

Copy the jar file to the docker container
```
docker cp ~/sample-KafkaSparkHBase-1.0-SNAPSHOT.jar aio:/root/
```

In the docker container, use spark-submit to run the Spark job.
```
/opt/spark-2.3.1-bin-hadoop2.7/bin/spark-submit --class KafkaSparkHBase /root/sample-KafkaSparkHBase-1.0-SNAPSHOT.jar
```

## References
https://hortonworks.com/tutorial/setting-up-a-spark-development-environment-with-java/

https://github.com/ccbt87/sample-KafkaSparkHBase
