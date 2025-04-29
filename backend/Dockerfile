FROM php:8.1-apache

# 1. Installa pacchetti di sistema + estensioni GD e mysqli
RUN apt-get update && apt-get install -y \
      libpng-dev libjpeg-dev libfreetype6-dev zip unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Abilita mod_rewrite
RUN a2enmod rewrite

# 3. Copia Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 4. Imposta la document root
WORKDIR /var/www/html

# 5. Copia il backend nel contesto (Render build context = backend/)
COPY . .

# 6. Installa dipendenze PHP
RUN composer install --no-dev --optimize-autoloader || true

# 7. Espone la porta 80 e avvia Apache
EXPOSE 80
CMD ["apache2-foreground"]
