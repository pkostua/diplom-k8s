# Настройка Kubernetes Monitoring Stack

## Быстрый старт

### 1. Предварительные требования

Убедитесь, что у вас есть:
- Kubernetes кластер (версия 1.19+)
- Nginx Ingress Controller
- StorageClass `yc-network-hdd`
- kubectl настроен для работы с кластером

### 2. Развертывание

```bash
# Сделайте скрипты исполняемыми
chmod +x deploy.sh cleanup.sh

# Разверните мониторинг
./deploy.sh
```

### 3. Проверка развертывания

```bash
# Проверьте статус подов
kubectl get pods -n monitoring

# Проверьте сервисы
kubectl get services -n monitoring

# Проверьте Ingress
kubectl get ingress -n monitoring
```

## Доступ к сервисам

После успешного развертывания сервисы будут доступны по следующим URL:

- **Grafana**: `http://grafana.pkdp.ru`
  - Логин: `admin`
  - Пароль: `MSPrd123!`

  
## Настройка

### Изменение пароля Grafana

Пароль можно изменить в следующих файлах:

1. `13-grafana-configmap.yaml` - в секции `[security]`

### Добавление дашбордов

Новые дашборды можно добавить в:
- `14-grafana-dashboards-configmap.yaml` - базовые дашборды
- `24-grafana-kubernetes-dashboards.yaml` - дашборды для Kubernetes

### Настройка алертов

Алерты настраиваются в:
- `22-prometheus-rules-configmap.yaml` - правила алертов Prometheus
- `06-alertmanager-configmap.yaml` - конфигурация Alertmanager


