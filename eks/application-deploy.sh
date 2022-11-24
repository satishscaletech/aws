#Deploy application steps
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.4/docs/examples/2048/2048_full.yaml

kubectl get ingress/ingress-2048 -n game-2048