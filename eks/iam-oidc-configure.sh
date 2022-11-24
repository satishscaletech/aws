oidc_id=$(aws eks describe-cluster --name my-eks-demo --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)

aws iam list-open-id-connect-providers | grep $oidc_id


eksctl utils associate-iam-oidc-provider --cluster my-eks-demo --approve