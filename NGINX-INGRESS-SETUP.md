# Установка NGINX Ingress Controller

## Предварительные требования

1. **Kubernetes кластер** (версия 1.19+)
2. **Helm** (версия 3.0+)
3. **kubectl** настроен для работы с кластером
4. **Права доступа** к кластеру для создания LoadBalancer сервисов

## Установка Helm

Если Helm не установлен, установите его:

### Linux/macOS:
```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

### Windows:
```powershell
# Скачайте и установите с https://github.com/helm/helm/releases
```

## Быстрая установка

### 1. Простая установка (рекомендуется для начала)

```bash
chmod +x install-nginx-ingress-simple.sh
./install-nginx-ingress-simple.sh
```

### 2. Расширенная установка (с дополнительными настройками)

```bash
chmod +x install-nginx-ingress.sh
./install-nginx-ingress.sh
```

### 3. Ручная установка

```bash
# Добавление репозитория
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# Обновление репозиториев
helm repo update

# Установка NGINX Ingress Controller
helm install ingress-nginx ingress-nginx/ingress-nginx \
    --namespace ingress-nginx \
    --create-namespace \
    --set controller.service.type=LoadBalancer
```

## Проверка установки

### Автоматическая проверка:
```bash
chmod +x check-nginx-status.sh
./check-nginx-status.sh
```

### Ручная проверка:
```bash
# Проверка подов
kubectl get pods -n ingress-nginx

# Проверка сервисов
kubectl get svc -n ingress-nginx

# Проверка внешнего IP
kubectl get svc ingress-nginx-controller -n ingress-nginx -o wide

# Мониторинг статуса LoadBalancer
kubectl --namespace ingress-nginx get services -o wide -w ingress-nginx-controller
```

## Дополнительные ресурсы

- [Официальная документация NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/)
- [Helm Chart документация](https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx)
- [Примеры конфигурации](https://kubernetes.github.io/ingress-nginx/examples/)
