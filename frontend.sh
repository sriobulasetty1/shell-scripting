#!/bin/bash

#we have to use source command because it has functions and other variables.
#source components/common.sh
print "installing nginx"
yum install nginx -y &>> $LOG_FILE
StatCheck $?

print "download"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>> $LOG_FILE
StatCheck $?

print "cleanup"
rm -rf /usr/share/nginx/html/* && cd /usr/share/nginx/html && unzip /tmp/frontend.zip &>> $LOG_FILE && mv frontend-main/* . && mv static/* . && rm -rf frontend-main README.md && mv localhost.conf /etc/nginx/default.d/roboshop.conf &>> $LOG_FILE
StatCheck $?

print "start"
systemctl restart nginx
systemctl enable nginx
StatCheck $?