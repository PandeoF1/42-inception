FROM debian:buster

ARG WP_DB_NAME_A
ARG WP_DB_LOGIN_A
ARG WP_DB_PASSWORD_A
ARG WP_DB_HOST_A

ENV WP_DB_LOGIN=$WP_DB_LOGIN_A
ENV WP_DB_PASSWORD=$WP_DB_PASSWORD_A
ENV WP_DB_HOST=$WP_DB_HOST_A
ENV WP_DB_NAME=$WP_DB_NAME_A

RUN apt-get update
RUN apt-get -y install git php7.3 php-fpm php7.3-mysql php7.3-curl php7.3-json php7.3-mbstring php7.3-xml php7.3-zip php7.3-gd php7.3-soap php7.3-ssh2 php7.3-tokenizer wget php-mysqli sendmail php7.3-common

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./tools /var/www/

RUN sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf" && chown -R www-data:www-data /var/www/* && chown -R 755 /var/www/* && mkdir -p /run/php/ && touch /run/php/php7.3-fpm.pid && mkdir -p /var/www/html && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  && chmod +x wp-cli.phar  && mv wp-cli.phar /usr/local/bin/wp  && cd /var/www/html  && wp core download --allow-root && mv /var/www/wp-config.php /var/www/html/ && sed -i "s/db_name_to_remove/${WP_DB_NAME}/" /var/www/html/wp-config.php && sed -i "s/db_user_to_remove/${WP_DB_LOGIN}/" /var/www/html/wp-config.php && sed -i "s/db_passwd_to_remove/${WP_DB_PASSWORD}/" /var/www/html/wp-config.php && sed -i "s/db_host_to_remove/${WP_DB_HOST}/" /var/www/html/wp-config.php

RUN chmod +x /var/www/wordpress_start.sh

RUN mkdir -p /var/www/adminer && cd /var/www/adminer && wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php -O index.php && chown -R www-data:www-data /var/www/adminer
RUN mkdir -p /var/www/perso && cd /var/www/perso && git clone https://github.com/PandeoF1/pandeo.fr.git . && chown -R www-data:www-data /var/www/perso

ENTRYPOINT [ "/var/www/wordpress_start.sh" ]

CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]