#!/bin/bash
###----------Author: Davies-------------

#-----------Date: Feb. 13/2023-----------

#---------Description-------------------
#This script when executed will install Sonarqube on your CentOS server
#This process need to be run as a regular user ( Sonarqube doesnt work when you start it as root user)

su - vagrant

if [ $? -ne 0]

then 
   echo " You need to login as a regulat user in order to install Sonarqube "
   exit 1
fi

 #----------Step 1: Java 11 Installation------------------------------
 #The only prerequisite for running SonarQube is to have Java (Oracle JRE 11 or OpenJDK 11) installed on your machine. To install OpenJDK 11, run the following commands

sudo yum update -y

if 
   [ $? -ne 0 ]

then 
   echo "yum was unable to update"
   exit 2
fi 

sudo yum install java-11-openjdk-devel -y

if 
   [ $? -ne 0 ]

then
    echo "java-11-openjdk-devel was unable to install"
    exit 3
fi 

sudo yum install java-11-openjdk -y

if
   [ $? -ne 0 ]

then
    echo "java-11-openjdk was unable to install"
    exit 3
fi

#-----------Step 2: Download SonarQube latest versions on your server-------------------
# Navigate to /opt before downloading

cd /opt

#To download wget

sudo yum install wget -y

sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zip

#-------------Step 3: Extract packages----------

sudo yum install unzip

sudo unzip /opt/sonarqube-9.3.0.51899.zip

if 
   [ $? -eq 0 ]

echo "file unzip successfully"

else 
   echo "file still zipped"
fi




#---------Step 4: Change ownership to the user and Switch to Linux binaries directory to start service----------------------------------------

sudo chown -R vagrant:vagrant /opt/sonarqube-9.3.0.51899

if 
   [ $? -eq 0 ]

echo "owner of the file has been changed to vagrant"

else 

echo "change unsuccessful"

fi

cd /opt/sonarqube-9.3.0.51899/bin/linux-x86-64

 ./sonar.sh start


echo "Sonarqube is successfully installed"
echo "Please get the IP address and your listening port and access your sonarqube on a browser" 
