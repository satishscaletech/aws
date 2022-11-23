# Step 1. Create IAM Role
aws iam create-role \
  --role-name nflDevEKSNodeRole \
  --assume-role-policy-document file://"node-role-trust-policy.json"

#Step 2. Attached required policy to the Role

aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy \
  --role-name nflDevEKSNodeRole

aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly \
  --role-name nflDevEKSNodeRole
  
aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy \
  --role-name nflDevEKSNodeRole