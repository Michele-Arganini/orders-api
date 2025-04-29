# Usa PHP 8.1 + Apache
FROM php:8.1-apache

# 1. Installa GD e altri pacchetti di sistema
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev zip unzip \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install gd

# 2. Abilita mod_rewrite
RUN a2enmod rewrite

# 3. Copia Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 4. Imposta la document root di Apache
WORKDIR /var/www/html

# 5. Copia TUTTO il contenuto del contesto (che su Render è già `backend/`)
COPY . .

# 6. Installa le dipendenze PHP
RUN composer install --no-dev --optimize-autoloader || true

# 7. Espone la porta 80 e avvia Apache in foreground
EXPOSE 80
CMD ["apache2-foreground"]
