FROM php:7.4-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid
ARG githubOauth

# xdebug version
ENV XDEBUG_VERSION=2.9.8

# Install system dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update -yq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libpq-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_pgsql mbstring exif pcntl bcmath gd

RUN pecl install xdebug-${XDEBUG_VERSION}
RUN docker-php-ext-enable xdebug

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

COPY ./conf/*.ini /usr/local/etc/php/conf.d/
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/

RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs

# Set working directory
WORKDIR /var/www

USER $user

RUN composer config --global github-oauth.github.com $githubOauth