# ResetServer

## Опис
Цей проект включає в себе веб-додаток на Flask, налаштований з використанням Nginx як зворотного проксі сервера та Gunicorn як WSGI сервера. Все це розгортається у Docker-контейнерах з використанням Docker Compose. Також включено налаштування для Locust, щоб проводити навантажувальне тестування додатку.

## Вимоги
Для запуску проекту вам потрібно мати встановлені:
- Docker
- Docker Compose

## Збірка та запуск проекту
1. **Клонування репозиторію**
   ```
   git clone <url вашого репозиторію>
   cd <назва вашої папки проекту>
   ```

2. **Збірка та запуск Docker контейнерів**
   ```
   docker-compose up --build
   ```

   Ця команда збудує необхідні Docker образи та запустить контейнери.

3. **Перевірка**
   Після запуску, ваш веб-додаток буде доступний за адресою `https://localhost:443` або `https://<ваш IP>:443`. 
4. Kibana - `http://localhost:5601/`



## Запуск навантажувального тестування з Locust
1. Запустіть Locust локально:
   ```
   locust
   ```
2. Відкрийте веб-інтерфейс Locust у браузері:
   ```
   http://localhost:8089
   ```
3. Введіть кількість користувачів, швидкість спавну та хост (наприклад, `http://localhost:5000`), і натисніть "Start Swarming".

## Архітектура
- **Flask**: Веб-додаток, який працює як основний сервіс.
- **Nginx**: Виступає зворотним проксі для Flask, забезпечуючи SSL/TLS.
- **Gunicorn**: WSGI сервер, який обслуговує Flask додаток.
- **Filebeat**: Збирає логи з Nginx та відправляє їх до Elasticsearch.
- **Elasticsearch**: База даних для зберігання логів.
- **Kibana**: Веб-інтерфейс для перегляду та аналізу логів з Elasticsearch.

## Ліцензія
[MIT](https://choosealicense.com/licenses/mit/)
