#!bin/bash
#Create cluster configuration

#Step 1. Create Public/Private VPC subnet
#Replace region-code with actual region
aws cloudformation create-stack \
  --region us-east-1 \
  --stack-name nfl-dev-eks-vpc-stack \
  --template-url https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/amazon-eks-vpc-private-subnets.yaml

#Step 2. Create Role
aws iam create-role \
  --role-name nflDevEKSClusterRole \
  --assume-role-policy-document file://"eks-cluster-role-trust-policy.json"

#Step 3. Attach required policy to the Role
aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy \
  --role-name nflDevEKSClusterRole
