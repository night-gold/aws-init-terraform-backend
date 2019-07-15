# Setting up Terraform S3 backend

The script create a S3 bucket with it's DynamoDB table for tfstate locking.

# Prerequisite

Before launching script, login to awscli with an account having s3api full access and DynamoDB create table access.

# Example:

Clone project, then execute:
```bash
chmod +x setup.sh
./setup.sh PROJECT ENV REGION
```

# Variables

- PROJECT: is to distinguished your bucket and table id you have multiple project on the same account
- ENV: dev,preprod,uat... Put what you want here
- REGION: The region where you want your bucket.
