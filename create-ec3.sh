#!/bin/bash

echo " Creating instance with out security groups and spot instance"
if [ -z "$1" ]; then
  echo -e "Input Machine name"
  exit 1
fi

COMPONENT=$1

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" | jq '.Images[].ImageId' | sed -e 's/"//g')

echo $AMI_ID
aws ec2 run-instances --image-id ${AMI_ID} --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"

