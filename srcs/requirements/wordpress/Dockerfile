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
RUN apt-get -y install php7.3 php-fpm php7.3-mysql php7.3-curl php7.3-json php7.3-mbstring php7.3-xml php7.3-zip php7.3-gd php7.3-soap php7.3-ssh2 php7.3-tokenizer wget php-mysqli sendmail php7.3-common

EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./tools /var/www/

RUN chmod +x /var/www/wordpress_start.sh

RUN sh /var/www/wordpress_start.sh

CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]