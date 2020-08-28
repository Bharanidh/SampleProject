#!/bin/sh
#Purpose: To get the Infra/App details from Linux Machines
#Coded by: b.deenadayalu/Annapoorani.krishna

httpd()
{
#To check whether httpd process is running and get the configuration file.
rm -rf httpd.conf_path.txt
echo "*********************************************" >> Server_$HOSTNAME.txt
echo "Apache httpd Service discovery" >> Server_$HOSTNAME.txt
echo "*********************************************" >> Server_$HOSTNAME.txt

SERVICE="httpd"
if pgrep -x "$SERVICE" >/dev/null
then
    echo "Service Status: $SERVICE is running" >> Server_$HOSTNAME.txt
    echo "$(httpd -v)" >> Server_$HOSTNAME.txt
    echo "Port No and process ID for $SERVICE:" >> Server_$HOSTNAME.txt
    netstat -nlptu | grep $SERVICE >> Server_$HOSTNAME.txt
else
    echo "Service Status: $SERVICE stopped or not available" >> Server_$HOSTNAME.txt
fi
echo "*********************************************" >> Server_$HOSTNAME.txt
echo "httpd configuration file path details if available in the server:" >> Server_$HOSTNAME.txt
find / -name httpd.conf >> Server_$HOSTNAME.txt
echo "*********************************************" >> Server_$HOSTNAME.txt
echo "httpd modules if available in the server:" >> Server_$HOSTNAME.txt
echo "*********************************************" >> Server_$HOSTNAME.txt
find / -name mod_*so >> Server_$HOSTNAME.txt
echo "*********************************************" >> Server_$HOSTNAME.txt
grep httpd.conf Server_$HOSTNAME.txt > httpd.conf_path.txt
echo "*********************************************" >> Server_$HOSTNAME.txt
echo "DocumentRoot available in the httpd server:" >> Server_$HOSTNAME.txt
echo "*********************************************" >> Server_$HOSTNAME.txt
sed -i '1d' httpd.conf_path.txt
for i in `cat httpd.conf_path.txt`
do
grep '^DocumentRoot' $i >> Server_$HOSTNAME.txt
done
echo "*********************************************" >> Server_$HOSTNAME.txt
}
tomcat()
{
echo "*********************************************" >> Server_$HOSTNAME.txt
echo "Tomcat discovery" >> Server_$HOSTNAME.txt
echo "*********************************************" >> Server_$HOSTNAME.txt
#ps -ef | grep tomcat > test
#tomcatcount=`wc -l test | awk '{ print $1 }'`
#   if [ $tomcatcount -gt "2" ]
tomcatcount=`ps -ef | grep tomcat | wc -c`
  if [ $tomcatcount -gt "180" ]
   then
   echo "Tomcat process is running" >> Server_$HOSTNAME.txt
   else
   echo "Tomcat is stopped or not available" >> Server_$HOSTNAME.txt
   fi
   tomcatversion=`find / -type f -name version.sh | grep tomcat`
if [ -z "$tomcatversion" ]
then
   tomcatversion=`find / -type f -name version.sh`
   fi
echo "**********************************************" >> Server_$HOSTNAME.txt
   sh $tomcatversion >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
}
certificate_file()
{
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "Certificates path discovery" >> Server_$HOSTNAME.txt
find / -type f -name *.pem >> Server_$HOSTNAME.txt;find / -type f -name *.crt >> Server_$HOSTNAME.txt;find / -type f -name *.key >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
}
infra_details()
{
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "Infrastructure/Application Details:" >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo HOSTNAME:$HOSTNAME >> Server_$HOSTNAME.txt
echo IP Address:$(hostname -i) >> Server_$HOSTNAME.txt
echo Linux Kernel Version: $(uname -a) >> Server_$HOSTNAME.txt
echo Date and Time: $(date) >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "OS Version details:" >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
cat /etc/*-release >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "JAVA Version details:" >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
java -version 2>> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "Disk space details in human readable form:" >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
df -h >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "CPU architecture information from sysfs and /proc/cpuinfo" >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
lscpu >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "All active or inactive network interfaces details " >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
ifconfig -a >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "etc/hosts entry details " >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
cat /etc/hosts >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "Memory usage of the operating system details " >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
free -g  >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "All open ports or currently running ports including TCP and UDP " >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
netstat -ntupa  >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "Route Table information" >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
route -n >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "User account information" >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
cat /etc/passwd >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "User account group information" >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
cat /etc/group >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "All available disks, disk partitions and their options" >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
cat /etc/fstab >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "Listing the YUM Repos" >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo $(yum repolist) >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "Listing the YUM group list" >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo $(yum grouplist) >> Server_$HOSTNAME.txt
#echo $(yum list all) >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "Display the processes of all users" >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
ps aux >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "Cronjobs scheduled " >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
crontab -l >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
echo "Displays set resources limit for logged in user" >> Server_$HOSTNAME.txt
echo "**********************************************" >> Server_$HOSTNAME.txt
ulimit -a >> Server_$HOSTNAME.txt

echo "**************************************" >> Server_$HOSTNAME.txt
echo "Additional details" >> Server_$HOSTNAME.txt
echo "**************************************" >> Server_$HOSTNAME.txt
cat /proc/meminfo >> Server_$HOSTNAME.txt
cat /proc/cpuinfo >> Server_$HOSTNAME.txt
lspci >> Server_$HOSTNAME.txt
lsblk >> Server_$HOSTNAME.txt
}
echo '--------------------------------------'
echo ' Infrastructure/Application Discovery '
echo '--------------------------------------'

echo '**********************************************************'
echo 'Enter the option(1-5) to execute the corresponding module:'
echo '**********************************************************'

select MENU in infra_details httpd tomcat certificate_file Exit

do

case "$MENU" in

infra_details)
     infra_details
        ;;

httpd)
     httpd
        ;;

tomcat)
     tomcat
        ;;

certificate_file)
     certificate_file
       ;;

 Exit)
        break 
        ;;
	
esac
done
