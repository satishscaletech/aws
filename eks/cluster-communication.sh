#Step 1. Create or update kubeconfig 
#Replace region-code with region and my-cluster with #acutual cluster name
aws eks update-kubeconfig --region ca-central-1 \
--name my-amazon-eks-cluster

#Step 2. Test Configuration
kubectl get svc