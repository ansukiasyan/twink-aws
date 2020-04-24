#!/bin/bash

# Stop and disable some services
systemctl stop postfix
systemctl disable postfix

systemctl stop rpcbind
systemctl disable rpcbind
systemctl mask rpcbind
systemctl stop rpcbind.socket
systemctl disable rpcbind.socket


#yum db clean and update
yum clean all
yum update -y

#install apache
yum install httpd -y

#start apache on default port 80
systemctl start httpd

#turn on apache service on reboot
systemctl enable httpd

#download index.html file from an s3 bucket
rm -f /var/www/html/index.html
aws s3 cp s3://annas-twink-s3/index.html /var/www/html

