#!/bin/bash
sudo su

#yum db clean and update
yum clean all
yum update -y

#install apache
yum install httpd -y

#start apache on default port 80
service httpd start

#turn apache service on after reboot
chkconfig httpd on

cd /var/www/html

#download index.html file from an s3 bucket
aws s3 cp s3://annas-twink-s3/index.html /var/www/html