curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.4/docs/install/iam_policy.json


aws iam create-policy \
    --policy-name MyEKSDemoAWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

eksctl create iamserviceaccount \
  --cluster=my-eks-demo \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name "MyEksDemoAmazonEKSLoadBalancerControllerRole" \
  --attach-policy-arn=arn:aws:iam::249373568965:policy/MyEKSDemoAWSLoadBalancerControllerIAMPolicy \
  --approve

kubectl apply \
    --validate=false \
    -f https://github.com/jetstack/cert-manager/releases/download/v1.5.4/cert-manager.yaml


curl -Lo v2_4_4_full.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.4.4/v2_4_4_full.yaml

sed -i.bak -e '480,488d' ./v2_4_4_full.yaml

sed -i.bak -e 's|your-cluster-name|my-eks-demo|' ./v2_4_4_full.yaml

sed -i.bak -e 's|amazon/aws-alb-ingress-controller|249373568965.dkr.ecr.ca-central-1.amazonaws.com/amazon/aws-alb-ingress-controller|' ./v2_4_4_full.yaml

kubectl apply -f v2_4_4_full.yaml

curl -Lo v2_4_4_ingclass.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.4.4/v2_4_4_ingclass.yaml


kubectl apply -f v2_4_4_ingclass.yaml


kubectl get deployment -n kube-system aws-load-balancer-controller



