# Скрипты для установки и управления

## NGINX Ingress Controller

### Установка
- `install-nginx-ingress-simple.sh` - Простая установка NGINX Ingress Controller
- `install-nginx-ingress.sh` - Расширенная установка с дополнительными настройками

### Управление
- `check-nginx-status.sh` - Проверка статуса NGINX Ingress Controller
- `test-ingress.sh` - Тестирование работы Ingress с тестовым приложением
- `uninstall-nginx-ingress.sh` - Удаление NGINX Ingress Controller

## Мониторинг

### Развертывание
- `deploy.sh` - Полное развертывание стека мониторинга
- `cleanup.sh` - Удаление всего стека мониторинга

## Порядок установки

### 1. Установка NGINX Ingress Controller
```bash
# Простая установка (рекомендуется)
chmod +x install-nginx-ingress-simple.sh
./install-nginx-ingress-simple.sh

# Проверка установки
chmod +x check-nginx-status.sh
./check-nginx-status.sh

# Тестирование
chmod +x test-ingress.sh
./test-ingress.sh
```

### 2. Развертывание мониторинга
```bash
# Развертывание мониторинга
chmod +x deploy.sh
./deploy.sh

# Проверка статуса
kubectl get pods -n monitoring
kubectl get ingress -n monitoring
```

### 3. Доступ к сервисам
После установки сервисы будут доступны по адресам:
- **Grafana**: `http://grafana.pkdp.ru`

## Удаление

### Удаление мониторинга
```bash
chmod +x cleanup.sh
./cleanup.sh
```

### Удаление NGINX Ingress Controller
```bash
chmod +x uninstall-nginx-ingress.sh
./uninstall-nginx-ingress.sh
```

## Дополнительные файлы

### Конфигурация
- `test-app.yaml` - Тестовое приложение 
- Все файлы `*.yaml` - Конфигурации компонентов мониторинга

### Документация
- `README.md` - Основная документация
- `SETUP.md` - Подробные инструкции по настройке
- `NGINX-INGRESS-SETUP.md` - Документация по NGINX Ingress Controller
- `SCRIPTS.md` - Этот файл со списком скриптов

## Проверка работоспособности

### Проверка NGINX Ingress Controller
```bash
# Получение внешнего IP
kubectl get svc ingress-nginx-controller -n ingress-nginx

# Проверка доступности
curl -I http://<EXTERNAL_IP>
```

### Проверка мониторинга
```bash
# Проверка подов
kubectl get pods -n monitoring

# Проверка сервисов
kubectl get svc -n monitoring

# Проверка Ingress
kubectl get ingress -n monitoring
```

## Устранение неполадок

### Проблемы с NGINX Ingress Controller
```bash
# Проверка логов
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller

# Проверка событий
kubectl get events -n ingress-nginx --sort-by='.lastTimestamp'
```

### Проблемы с мониторингом
```bash
# Проверка логов Prometheus
kubectl logs -n monitoring deployment/prometheus

# Проверка логов Grafana
kubectl logs -n monitoring deployment/grafana

# Проверка событий
kubectl get events -n monitoring --sort-by='.lastTimestamp'
```
