#!/bin/bash

echo "Installing NGINX Ingress Controller (Simple Version)..."

# Проверка наличия Helm
if ! command -v helm &> /dev/null; then
    echo "Error: Helm is not installed. Please install Helm first."
    echo "Visit: https://helm.sh/docs/intro/install/"
    exit 1
fi

# Проверка подключения к кластеру
if ! kubectl cluster-info &> /dev/null; then
    echo "Error: Cannot connect to Kubernetes cluster. Please check your kubeconfig."
    exit 1
fi

echo "Adding NGINX Ingress Controller Helm repository..."
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

echo "Updating Helm repositories..."
helm repo update

echo "Installing NGINX Ingress Controller..."
helm install ingress-nginx ingress-nginx/ingress-nginx \
    --namespace ingress-nginx \
    --create-namespace \
    --set controller.service.type=LoadBalancer \
    --set controller.resources.requests.cpu=100m \
    --set controller.resources.requests.memory=128Mi \
    --set controller.resources.limits.cpu=200m \
    --set controller.resources.limits.memory=256Mi \
    --set controller.config.enable-real-ip=true \
    --set controller.config.use-forwarded-headers=true \
    --set controller.config.server-tokens=false \
    --set controller.config.proxy-body-size=50m \
    --set controller.config.gzip=on \
    --set controller.config.gzip-types="text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript"

echo ""
echo "NGINX Ingress Controller installation completed!"
echo ""
echo "Waiting for LoadBalancer IP to be available..."
echo "You can watch the status by running:"
echo "kubectl --namespace ingress-nginx get services -o wide -w ingress-nginx-controller"
echo ""
echo "To check the installation status:"
echo "kubectl get pods -n ingress-nginx"
echo "kubectl get svc -n ingress-nginx"
echo ""
echo "To get the external IP address:"
echo "kubectl get svc ingress-nginx-controller -n ingress-nginx"
echo ""
echo "To uninstall:"
echo "helm uninstall ingress-nginx -n ingress-nginx"
