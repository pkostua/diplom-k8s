#!/bin/bash

echo "Checking NGINX Ingress Controller Status..."
echo "=========================================="

echo ""
echo "1. Checking pods status:"
kubectl get pods -n ingress-nginx

echo ""
echo "2. Checking services:"
kubectl get svc -n ingress-nginx

echo ""
echo "3. Checking LoadBalancer external IP:"
kubectl get svc ingress-nginx-controller -n ingress-nginx -o wide

echo ""
echo "4. Checking ingress-nginx namespace:"
kubectl get all -n ingress-nginx

echo ""
echo "5. Checking Helm releases:"
helm list -n ingress-nginx

echo ""
echo "6. Checking ingress-nginx controller logs (last 10 lines):"
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller --tail=10

echo ""
echo "7. Checking if LoadBalancer IP is assigned:"
EXTERNAL_IP=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
if [ -n "$EXTERNAL_IP" ]; then
    echo "External IP: $EXTERNAL_IP"
else
    echo "External IP: <pending>"
    echo "Note: It may take a few minutes for the LoadBalancer IP to be available."
fi

echo ""
echo "8. Testing nginx controller:"
kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}' | xargs -I {} curl -I http://{}:80 2>/dev/null || echo "Controller not ready yet or no external IP assigned"

echo ""
echo "=========================================="
echo "Status check completed!"
