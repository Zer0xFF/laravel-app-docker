FROM php:8.2-apache
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install system dependencies
RUN apt-get update
RUN apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

RUN apt-get install -y git curl unzip nodejs
RUN apt-get install -y libsqlite3-dev libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_sqlite gd

RUN a2enmod rewrite

# Increase PHP limits for larger workloads/uploads
RUN { \
    echo 'memory_limit=2G'; \
    echo 'upload_max_filesize=2G'; \
    echo 'post_max_size=2G'; \
    echo 'max_execution_time=300'; \
  } > /usr/local/etc/php/conf.d/99-custom-limits.ini

# Update Apache config to point to Laravel project public directory
RUN sed -i 's#/var/www/html#/var/www/html/public#g' /etc/apache2/sites-available/000-default.conf

# Copy the entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Expose port 80 for the web server
EXPOSE 80

# Set the entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]

# Start Apache server
CMD ["apache2-foreground"]
