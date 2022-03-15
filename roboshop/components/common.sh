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