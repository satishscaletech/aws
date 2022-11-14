#Reference https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html

oidc_id=$(aws eks describe-cluster --name my-amazon-eks-cluster --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)

aws iam list-open-id-connect-providers | grep $oidc_id

eksctl utils associate-iam-oidc-provider --cluster my-amazon-eks-cluster --approve


curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.4/docs/install/iam_policy.json


aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

eksctl create iamserviceaccount \
  --cluster=my-amazon-eks-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name "AmazonEKSLoadBalancerControllerRole" \
  --attach-policy-arn=arn:aws:iam::249373568965:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve

kubectl apply \
    --validate=false \
    -f https://github.com/jetstack/cert-manager/releases/download/v1.5.4/cert-manager.yaml


curl -Lo v2_4_4_full.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.4.4/v2_4_4_full.yaml

sed -i.bak -e '480,488d' ./v2_4_4_full.yaml

sed -i.bak -e 's|your-cluster-name|my-amazon-eks-cluster|' ./v2_4_4_full.yaml

sed -i.bak -e 's|amazon/aws-alb-ingress-controller|249373568965.dkr.ecr.ca-central-1.amazonaws.com/amazon/aws-alb-ingress-controller|' ./v2_4_4_full.yaml

kubectl apply -f v2_4_4_full.yaml

curl -Lo v2_4_4_ingclass.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.4.4/v2_4_4_ingclass.yaml


kubectl apply -f v2_4_4_ingclass.yaml


kubectl get deployment -n kube-system aws-load-balancer-controller


kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.4/docs/examples/2048/2048_full.yaml

kubectl get ingress/ingress-2048 -n game-2048


