#!/bin/bash
#Listen
sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
#Permission
chown -R www-data:www-data /var/www/*;
chown -R 755 /var/www/*;
mkdir -p /run/php/;
touch /run/php/php7.3-fpm.pid;
#Download auto setup
mkdir -p /var/www/html
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
chmod +x wp-cli.phar; 
mv wp-cli.phar /usr/local/bin/wp;
#Download core
cd /var/www/html;
wp core download --allow-root;

mv /var/www/wp-config.php /var/www/html/
#Config
sed -i "s/db_name_to_remove/${WP_DB_NAME}/" /var/www/html/wp-config.php
sed -i "s/db_user_to_remove/${WP_DB_LOGIN}/" /var/www/html/wp-config.php
sed -i "s/db_passwd_to_remove/${WP_DB_PASSWORD}/" /var/www/html/wp-config.php
sed -i "s/db_host_to_remove/${WP_DB_HOST}/" /var/www/html/wp-config.php

#Install core and user create
wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_LOGIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}
wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD};
#Final perm
chown -R www-data:www-data /var/www/html/wp-content
chmod -R 755 /var/www/html/

exec "$@"