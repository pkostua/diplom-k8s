#!/bin/bash

echo "Installing NGINX Ingress Controller..."

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
    --set controller.config.use-proxy-protocol=false \
    --set controller.config.use-forwarded-headers=true \
    --set controller.config.server-tokens=false \
    --set controller.config.proxy-body-size=50m \
    --set controller.config.proxy-connect-timeout=60 \
    --set controller.config.proxy-send-timeout=60 \
    --set controller.config.proxy-read-timeout=60 \
    --set controller.config.proxy-buffer-size=4k \
    --set controller.config.proxy-buffers-number=4 \
    --set controller.config.proxy-max-temp-file-size=1024m \
    --set controller.config.large-client-header-buffers=4 32k \
    --set controller.config.client-header-buffer-size=1k \
    --set controller.config.client-header-timeout=60 \
    --set controller.config.client-body-buffer-size=128k \
    --set controller.config.client-body-timeout=60 \
    --set controller.config.send-timeout=60 \
    --set controller.config.keep-alive-requests=100 \
    --set controller.config.keep-alive=on \
    --set controller.config.gzip=on \
    --set controller.config.gzip-types="text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript" \
    --set controller.config.gzip-min-length=1000 \
    --set controller.config.gzip-proxied=any \
    --set controller.config.gzip-comp-level=6 \
    --set controller.config.gzip-vary=on \
    --set controller.config.hide-headers="Server X-Powered-By X-AspNet-Version X-AspNetMvc-Version X-Runtime" \
    --set controller.config.add-headers="X-Frame-Options: SAMEORIGIN X-Content-Type-Options: nosniff X-XSS-Protection: 1; mode=block" \
    --set controller.config.broken-link-hash-bucket-size=1024 \
    --set controller.config.broken-link-hash-max-size=2048 \
    --set controller.config.limit-conn-zone="addr:10m" \
    --set controller.config.limit-conn="addr 10" \
    --set controller.config.limit-req-zone="addr:10m" \
    --set controller.config.limit-req="addr 10r/s" \
    --set controller.config.limit-rate="1024" \
    --set controller.config.limit-rate-after="1m" \
    --set controller.config.limit-req-status=429 \
    --set controller.config.limit-conn-status=503 \
    --set controller.config.limit-rate-status=429 \
    --set controller.config.limit-req-burst=20 \
    --set controller.config.limit-req-nodelay=true \
    --set controller.config.limit-conn-log-level=error \
    --set controller.config.limit-req-log-level=error \
    --set controller.config.limit-rate-log-level=error \
    --set controller.config.limit-conn-zone-key="$binary_remote_addr" \
    --set controller.config.limit-req-zone-key="$binary_remote_addr" \
    --set controller.config.limit-rate-zone-key="$binary_remote_addr" \
    --set controller.config.limit-conn-zone-size=10m \
    --set controller.config.limit-req-zone-size=10m \
    --set controller.config.limit-rate-zone-size=10m \
    --set controller.config.limit-conn-zone-rate=10r/s \
    --set controller.config.limit-req-zone-rate=10r/s \
    --set controller.config.limit-rate-zone-rate=1024 \
    --set controller.config.limit-conn-zone-burst=20 \
    --set controller.config.limit-req-zone-burst=20 \
    --set controller.config.limit-rate-zone-burst=2048 \
    --set controller.config.limit-conn-zone-nodelay=true \
    --set controller.config.limit-req-zone-nodelay=true \
    --set controller.config.limit-rate-zone-nodelay=true \
    --set controller.config.limit-conn-zone-log-level=error \
    --set controller.config.limit-req-zone-log-level=error \
    --set controller.config.limit-rate-zone-log-level=error \
    --set controller.config.limit-conn-zone-key-var="$binary_remote_addr" \
    --set controller.config.limit-req-zone-key-var="$binary_remote_addr" \
    --set controller.config.limit-rate-zone-key-var="$binary_remote_addr" \
    --set controller.config.limit-conn-zone-size-var=10m \
    --set controller.config.limit-req-zone-size-var=10m \
    --set controller.config.limit-rate-zone-size-var=10m \
    --set controller.config.limit-conn-zone-rate-var=10r/s \
    --set controller.config.limit-req-zone-rate-var=10r/s \
    --set controller.config.limit-rate-zone-rate-var=1024 \
    --set controller.config.limit-conn-zone-burst-var=20 \
    --set controller.config.limit-req-zone-burst-var=20 \
    --set controller.config.limit-rate-zone-burst-var=2048 \
    --set controller.config.limit-conn-zone-nodelay-var=true \
    --set controller.config.limit-req-zone-nodelay-var=true \
    --set controller.config.limit-rate-zone-nodelay-var=true \
    --set controller.config.limit-conn-zone-log-level-var=error \
    --set controller.config.limit-req-zone-log-level-var=error \
    --set controller.config.limit-rate-zone-log-level-var=error

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
