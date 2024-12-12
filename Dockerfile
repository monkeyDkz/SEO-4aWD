# Utiliser l'image officielle PHP avec Apache
FROM php:8.0-apache

# Installer les extensions PHP nécessaires
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Installer AWS CLI
RUN apt-get update && apt-get install -y \
    awscli

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Définir les variables d'environnement pour AWS
ENV AWS_ACCESS_KEY_ID=your_access_key_id
ENV AWS_SECRET_ACCESS_KEY=your_secret_access_key
ENV AWS_DEFAULT_REGION=your_default_region

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier les fichiers de l'application dans le conteneur
COPY . /var/www/html

# Installer les dépendances Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader || { cat /var/www/html/vendor/composer/installed.json; exit 1; }

# Donner les permissions nécessaires
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Activer le module Apache mod_rewrite
RUN a2enmod rewrite

# Copier le fichier de configuration Apache
COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf

# Exposer le port 80
EXPOSE 80

# Démarrer Apache
CMD ["apache2-foreground"]