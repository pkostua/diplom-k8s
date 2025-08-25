#!/bin/bash

echo "Uninstalling NGINX Ingress Controller..."

# Проверка наличия Helm
if ! command -v helm &> /dev/null; then
    echo "Error: Helm is not installed."
    exit 1
fi

# Проверка подключения к кластеру
if ! kubectl cluster-info &> /dev/null; then
    echo "Error: Cannot connect to Kubernetes cluster. Please check your kubeconfig."
    exit 1
fi

echo "Uninstalling NGINX Ingress Controller..."
helm uninstall ingress-nginx -n ingress-nginx

echo "Deleting ingress-nginx namespace..."
kubectl delete namespace ingress-nginx

echo ""
echo "NGINX Ingress Controller has been uninstalled!"
echo ""
echo "To verify removal:"
echo "kubectl get pods -n ingress-nginx"
echo "kubectl get svc -n ingress-nginx"
echo "helm list -n ingress-nginx"
