#!/bin/bash
set -e
set -u

if [ "$#" -lt "3" ]; then
  echo "usage: $0  <project> <env> <region>"
  echo "example: $0 lab-test test eu-west-1"
  exit 1
fi

# Create variable
project=$1; shift;
env=$1;shift;
region=$1;shift;

# Create bucket
aws s3api create-bucket --bucket $project-tfstate-$env --create-bucket-configuration LocationConstraint=$region --no-object-lock-enabled-for-bucket

# Activate bucket versionning
aws s3api put-bucket-versioning --bucket $project-tfstate-$env --versioning-configuration MFADelete=Disabled,Status=Enabled

# Lock bucket
aws s3api put-public-access-block --bucket $project-tfstate-$env --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

# Create DynamoDB table
aws dynamodb create-table --table-name terraform-state-$env-lock-dynamo --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=20,WriteCapacityUnits=20
