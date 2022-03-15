#!/bin/bash

#we have to use source command because it has functions and other variables.
source components/common.sh

print "Download Mongodb Repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$LOG_FILE
StatCheck $?

print "Install Mongodb"
yum install -y mongodb-org &>>$LOG_FILE

print "Start Mongodb"
systemctl enable mongod
systemctl start mongod
StatCheck $?

print "Download the schema and load it."
curl -f -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$LOG_FILE
StatCheck $?

print "Load schema"
cd /tmp && unzip mongodb.zip &>> $LOG_FILE && cd mongodb-main &>>$LOG_FILE
mongo < catalogue.js && mongo < users.js &>> $LOG_FILE
StatCheck $?