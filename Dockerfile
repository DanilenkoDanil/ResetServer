# Используйте более старый образ Ubuntu
FROM ubuntu:18.04

# Установите необходимые пакеты
RUN apt-get update && apt-get install -y \
    build-essential \
    libpcre3 \
    libpcre3-dev \
    zlib1g \
    zlib1g-dev \
    libssl-dev \
    openssl \
    vim \
    wget \
    tar \
    python3 \
    python3-pip

# Установите Flask и Gunicorn
RUN pip3 install Flask "gunicorn<20.0"

# Скопируйте ваше приложение Flask в контейнер
COPY app.py /app.py

# Скачайте и распакуйте исходный код Nginx
RUN wget https://nginx.org/download/nginx-1.10.3.tar.gz -O /tmp/nginx.tar.gz \
    && tar -xvzf /tmp/nginx.tar.gz -C /tmp

# Перейдите в директорию с исходным кодом и скомпилируйте Nginx
WORKDIR /tmp/nginx-1.10.3
RUN ./configure --with-http_ssl_module --with-http_v2_module \
    && sed -i 's/-Werror/-Wno-error/g' objs/Makefile \
    && make \
    && make install

# Создайте самоподписанный SSL сертификат
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"

# Создание директорий для логов Nginx и установка прав
RUN mkdir -p /var/log/nginx && \
    touch /var/log/nginx/access.log && \
    touch /var/log/nginx/error.log && \
    chmod -R 755 /var/log/nginx

# Копирование настроенного файла конфигурации Nginx
COPY nginx.conf /usr/local/nginx/conf/nginx.conf

# Определите порт и запустите Nginx и Gunicorn
EXPOSE 443
CMD cd / && gunicorn -w 4 -b 0.0.0.0:5000 app:app & /usr/local/nginx/sbin/nginx -g "daemon off;"