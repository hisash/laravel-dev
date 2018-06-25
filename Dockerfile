FROM php:7.2.6-fpm

RUN apt-get update \
  && apt-get install -y -qq \
             libfreetype6-dev \
             libjpeg62-turbo-dev \
             libmcrypt-dev \
             libpng-dev \
             openssl \
             libssl-dev \
             libxml2-dev \
             zlib1g-dev \
             curl \
             wget \
             nginx \
             vim \
             git \
             supervisor \
             mysql-client \
  && docker-php-ext-install \
             gd \
             pdo_mysql \
             mysqli \
             xmlrpc \
             zip

ENV COMPOSER_HOME /composer
ENV PATH /composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN curl -s http://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

ADD ./conf/nginx.conf /etc/nginx/sites-available/default
ADD ./conf/www.conf /usr/local/etc/php-fpm.d/zz-docker.conf
ADD ./conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV LANG C.UTF-8
RUN mkdir -p /var/www

CMD ["supervisord"]
