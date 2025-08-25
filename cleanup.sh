#!/bin/bash

echo "Cleaning up Kubernetes Monitoring Stack..."

# Удаление Ingress
echo "Removing Ingress..."
kubectl delete -f 21-alertmanager-ingress.yaml --ignore-not-found=true
kubectl delete -f 20-prometheus-ingress.yaml --ignore-not-found=true
kubectl delete -f 19-grafana-ingress.yaml --ignore-not-found=true

# Удаление Grafana
echo "Removing Grafana..."
kubectl delete -f 18-grafana-service.yaml --ignore-not-found=true
kubectl delete -f 17-grafana-datasources-configmap.yaml --ignore-not-found=true
kubectl delete -f 16-grafana-deployment.yaml --ignore-not-found=true
kubectl delete -f 15-grafana-pvc.yaml --ignore-not-found=true
kubectl delete -f 24-grafana-kubernetes-dashboards.yaml --ignore-not-found=true
kubectl delete -f 14-grafana-dashboards-configmap.yaml --ignore-not-found=true
kubectl delete -f 13-grafana-configmap.yaml --ignore-not-found=true

# Удаление kube-state-metrics
echo "Removing kube-state-metrics..."
kubectl delete -f 12-kube-state-metrics-service.yaml --ignore-not-found=true
kubectl delete -f 11-kube-state-metrics-deployment.yaml --ignore-not-found=true

# Удаление Node Exporter
echo "Removing Node Exporter..."
kubectl delete -f 10-node-exporter-service.yaml --ignore-not-found=true
kubectl delete -f 09-node-exporter-deployment.yaml --ignore-not-found=true

# Удаление Alertmanager
echo "Removing Alertmanager..."
kubectl delete -f 08-alertmanager-service.yaml --ignore-not-found=true
kubectl delete -f 07-alertmanager-deployment.yaml --ignore-not-found=true
kubectl delete -f 06-alertmanager-configmap.yaml --ignore-not-found=true

# Удаление Prometheus
echo "Removing Prometheus..."
kubectl delete -f 05-prometheus-service.yaml --ignore-not-found=true
kubectl delete -f 04-prometheus-deployment.yaml --ignore-not-found=true
kubectl delete -f 03-prometheus-pvc.yaml --ignore-not-found=true
kubectl delete -f 22-prometheus-rules-configmap.yaml --ignore-not-found=true
kubectl delete -f 02-prometheus-configmap.yaml --ignore-not-found=true

echo "Removing serviceaccount..."
kubectl delete -f 01_1-serviceaccount.yaml --ignore-not-found=true

# Удаление namespace
echo "Removing namespace..."
kubectl delete -f 01-namespace.yaml --ignore-not-found=true




echo "Cleanup completed!"
