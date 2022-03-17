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
  echo -e "====================$1==============" &>>$LOG_FILE
  echo -e "\e[36m $1 \e[0m"
}
LOG_FILE=/tmp/roboshop.log

print "Setup SystemD replace old with new hostnames"
sed -i -e 's/abc/xyz/' \
       -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal' \
       home/roboshop/${COMPONENT}/systemd.service
print "System service start and daemon reload"

SERVICE_SETUP() {
 systemctl daemon-reload &>>$LOGILFE && systemctl restart ${COMPONENT}.service
 }
