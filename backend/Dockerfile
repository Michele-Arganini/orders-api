# Usa PHP con Apache come base
FROM php:8.1-apache

# Installa dipendenze di sistema
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Abilita mod_rewrite di Apache
RUN a2enmod rewrite

# Installa Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Imposta la directory di lavoro
WORKDIR /var/www/html

# Copia tutto il progetto
COPY . .

# Installa le dipendenze PHP
RUN composer install --no-dev --optimize-autoloader

# Setta i permessi se necessario (opzionale)
# RUN chown -R www-data:www-data /var/www/html

# Espone la porta 80
EXPOSE 80

# Avvia Apache
CMD ["apache2-foreground"]
