#!/bin/bash

USER_UD=$(id -u)
if [ $USER_ID -ne 0 ]; then
   echo you should run as root
   ecit 1
fi
echo -e "\e[36m Installing nginx \e[0m"
yum install nginx -y


echo -e "\e[36m Download nginx \e[0m"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"

echo -e "\e[36m Update nginx \e[0m"
rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html/
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[36m Restart nginx \e[0m"
systemctl restart nginx
systemctl enable nginx