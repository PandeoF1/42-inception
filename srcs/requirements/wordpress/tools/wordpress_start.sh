#!/bin/sh

if [ ! -f "/var/www/setup" ]; then
	cd /var/www/html
	wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_LOGIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}
	wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD};
	wp plugin install redis-cache --activate --allow-root
	wp plugin update --all --allow-root
	touch /var/www/setup
fi

chown -R www-data:www-data /var/www/html/wp-content
chmod -R 755 /var/www/html/

wp redis enable --allow-root

exec "$@"