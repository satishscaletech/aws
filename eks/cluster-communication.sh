#Step 1. Create or update kubeconfig 
#Replace region-code with region and my-cluster with #acutual cluster name
aws eks update-kubeconfig --region us-east-1 \
--name nfl-staging

#Step 2. Test Configuration
kubectl get svc