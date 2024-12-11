# Utiliser l'image officielle PHP avec Apache
FROM php:8.0-apache

# Installer les extensions PHP nécessaires
RUN docker-php-ext-install pdo pdo_mysql

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copier les fichiers de l'application dans le conteneur
COPY . /var/www/html

# Définir le répertoire de travail
WORKDIR /var/www/html

# Installer les dépendances Composer
RUN composer install

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