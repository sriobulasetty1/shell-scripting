#!/bin/bash

StatCheck() {
  if [ "$1" -eq 0 ];then
    echo SUCCESS
    else
      echo FAILURE
      exit 2
      fi
      }

print() {
  echo -e "====================$1=============="
  echo -e "\e[36m $1 \e[0m"
}

LOG_FILE=/tmp/roboshop.log
print "installing nginx"
yum install nginx -y >> $LOG_FILE
StatCheck $?

print "download"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >> $LOG_FILE
StatCheck $?

print "cleanup"
rm -rf /usr/share/nginx/html/* && cd /usr/share/nginx/html && unzip /tmp/frontend.zip && mv frontend-main/* . && mv static/* . && rm -rf frontend-main README.md && mv localhost.conf /etc/nginx/default.d/roboshop.conf
StatCheck $?

print "start"
systemctl restart nginx
systemctl enable nginx
StatCheck $?