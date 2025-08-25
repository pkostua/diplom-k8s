# Kubernetes Monitoring Stack

Этот набор конфигураций разворачивает полный стек мониторинга Kubernetes, включающий:

- **Prometheus** - система сбора метрик
- **Grafana** - система визуализации 
- **Alertmanager** - система управления алертами
- **Node Exporter** - экспортер метрик узлов
- **kube-state-metrics** - экспортер метрик состояния Kubernetes

## Компоненты

### Grafana
- **Пароль по умолчанию**: `MSPrd123!`
- **Логин**: `admin`
- **Доступ**: `http://grafana.pkdp.ru`


## Развертывание

### Предварительные требования

1. Kubernetes кластер с поддержкой Ingress
2. NGINX Ingress Controller (см. раздел "Установка NGINX Ingress Controller")
3. StorageClass `yc-network-hdd` 

### Установка

```bash
# Создание namespace
kubectl apply -f 01-namespace.yaml

# Создание serviceaccount..."
kubectl apply -f 01_1-serviceaccount.yaml

# Установка компонентов мониторинга
kubectl apply -f 02-prometheus-configmap.yaml
kubectl apply -f 03-prometheus-pvc.yaml
kubectl apply -f 04-prometheus-deployment.yaml
kubectl apply -f 05-prometheus-service.yaml

kubectl apply -f 06-alertmanager-configmap.yaml
kubectl apply -f 07-alertmanager-deployment.yaml
kubectl apply -f 08-alertmanager-service.yaml

kubectl apply -f 09-node-exporter-deployment.yaml
kubectl apply -f 10-node-exporter-service.yaml

kubectl apply -f 11-kube-state-metrics-deployment.yaml
kubectl apply -f 12-kube-state-metrics-service.yaml

kubectl apply -f 13-grafana-configmap.yaml
kubectl apply -f 14-grafana-dashboards-configmap.yaml
kubectl apply -f 15-grafana-pvc.yaml
kubectl apply -f 16-grafana-deployment.yaml
kubectl apply -f 17-grafana-datasources-configmap.yaml
kubectl apply -f 18-grafana-service.yaml

# Настройка Ingress
kubectl apply -f 19-grafana-ingress.yaml
kubectl apply -f 20-prometheus-ingress.yaml
kubectl apply -f 21-alertmanager-ingress.yaml
```

### Проверка статуса

```bash
kubectl get pods -n monitoring
kubectl get services -n monitoring
kubectl get ingress -n monitoring
```

## Настройка

### Изменение пароля Grafana

Пароль можно изменить в следующих файлах:
- `13-grafana-configmap.yaml` - в секции `[security]`

### Добавление дашбордов

Новые дашборды можно добавить в `14-grafana-dashboards-configmap.yaml`

### Настройка алертов

Алерты настраиваются в `06-alertmanager-configmap.yaml`

## Доступ к сервисам

После развертывания сервисы будут доступны по следующим путям:
- Grafana: `http://grafana.pkdp.ru`



## Установка NGINX Ingress Controller

Перед развертыванием мониторинга необходимо установить NGINX Ingress Controller:

### Быстрая установка:
```bash
chmod +x install-nginx-ingress-simple.sh
./install-nginx-ingress-simple.sh
```

### Проверка установки:
```bash
chmod +x check-nginx-status.sh
./check-nginx-status.sh
```



Подробная документация по установке NGINX Ingress Controller находится в файле `NGINX-INGRESS-SETUP.md`.
