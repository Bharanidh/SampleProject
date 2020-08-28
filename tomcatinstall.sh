#!/bin/sh
#Purpose: Script to install Tomcat Server
echo "-----------------------------------------------"
echo "|                                              |"
echo "| YOU ARE INSTALLING TOMCAT APPLICATION SERVER |"
echo "-----------------------------------------------"
echo Please provide the application user for installing the tomcat
read user
useradd -d /home/$user $user
cd /home/$user
echo Please provide the version of tomcat to be installed like "8.5" or "9"
read version
if [ $version == 9 ]
then
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.37/bin/apache-tomcat-9.0.37.tar.gz
fi
if [ $version == 8.5 ]
then
wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.57/bin/apache-tomcat-8.5.57.tar.gz
fi
tar -xvf apache-tomcat*.tar.gz
rm -rf apache-tomcat*.tar.gz
mv apache-tomcat-* tomcat
chown -R $user:$user *