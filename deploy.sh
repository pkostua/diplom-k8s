#!/bin/bash

echo "Deploying Kubernetes Monitoring Stack..."

# Создание namespace
echo "Creating namespace..."
kubectl apply -f 01-namespace.yaml

echo "Creating serviceaccount..."
kubectl apply -f 01_1-serviceaccount.yaml

# Установка Prometheus
echo "Deploying Prometheus..."
kubectl apply -f 02-prometheus-configmap.yaml
kubectl apply -f 22-prometheus-rules-configmap.yaml
kubectl apply -f 03-prometheus-pvc.yaml
kubectl apply -f 04-prometheus-deployment.yaml
kubectl apply -f 05-prometheus-service.yaml

# Установка Alertmanager
echo "Deploying Alertmanager..."
kubectl apply -f 06-alertmanager-configmap.yaml
kubectl apply -f 07-alertmanager-deployment.yaml
kubectl apply -f 08-alertmanager-service.yaml

# Установка Node Exporter
echo "Deploying Node Exporter..."
kubectl apply -f 09-node-exporter-deployment.yaml
kubectl apply -f 10-node-exporter-service.yaml

# Установка kube-state-metrics
echo "Deploying kube-state-metrics..."
kubectl apply -f 11-kube-state-metrics-deployment.yaml
kubectl apply -f 12-kube-state-metrics-service.yaml

# Установка Grafana
echo "Deploying Grafana..."
kubectl apply -f 13-grafana-configmap.yaml
kubectl apply -f 14-grafana-dashboards-configmap.yaml
kubectl apply -f 24-grafana-kubernetes-dashboards.yaml
kubectl apply -f 15-grafana-pvc.yaml
kubectl apply -f 16-grafana-deployment.yaml
kubectl apply -f 17-grafana-datasources-configmap.yaml
kubectl apply -f 18-grafana-service.yaml

# Настройка Ingress
echo "Configuring Ingress..."
kubectl apply -f 19-grafana-ingress.yaml
kubectl apply -f 20-prometheus-ingress.yaml
kubectl apply -f 21-alertmanager-ingress.yaml

echo "Configuring test-app..."
kubectl apply -f test-app.yaml

echo "Deployment completed!"
echo ""
echo "Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app=prometheus -n monitoring --timeout=300s
kubectl wait --for=condition=ready pod -l app=grafana -n monitoring --timeout=300s
kubectl wait --for=condition=ready pod -l app=alertmanager -n monitoring --timeout=300s

echo ""
echo "Monitoring stack is ready!"
echo ""
echo "Access URLs:"
echo "- Grafana: http://your-domain/grafana (admin/MySecurePassword123!)"
echo "- Prometheus: http://your-domain/prometheus"
echo "- Alertmanager: http://your-domain/alertmanager"
echo ""
echo "Check status with:"
echo "kubectl get pods -n monitoring"
echo "kubectl get services -n monitoring"
echo "kubectl get ingress -n monitoring"
