FROM php:8.1-fpm

# Instalar extensões necessárias
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    mysql-client \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install gd \
    && docker-php-ext-install json \
    && docker-php-ext-install xml \
    && docker-php-ext-install mbstring

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Instalar Node.js e npm
RUN apt-get install -y nodejs npm

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Set permissions
RUN chown -R www-data:www-data /app

EXPOSE 8000 5173

CMD ["php-fpm"]
