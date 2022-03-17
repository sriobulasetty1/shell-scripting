#!/bin/bash

if [ -z "$1" ]; then
  echo -e "Input Machine Name"
  exit 1
fi


COMPONENT=$1
ZONE_ID="Z10446201CHRBX2OFKX"

create_ec2() {
PRIVATE_IP=$(aws ec2 run-instances \
      --image-id ${AMI_ID}  \
      --instance-type t2.micro \
      --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" \
      --instance-market-options "MarketType=spot,SpotOptions={$SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}" \
          --security-group-ids ${SGID} \
          | jq '.Instances[].PrivateIpAddress'| sed -e 's/"//g')

create_ec2

  sed -e "s/IPADDRESS/${PRIVATE_IP}/" -e "s/COMPONENT/${COMPONENT}/" route53.json > /tmp/record.json
  aws route53 change-resource-record-sets --hosted-zone-id ${ZONE_ID} --change-batch file:///tmp/record.json | jq

  }
  AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" | jq '.Images[].ImageId' | sed -e 's/"//g')
  SGID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=allow-all-from-public | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g')
