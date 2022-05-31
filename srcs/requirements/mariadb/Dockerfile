FROM debian:buster

ARG WP_DB_LOGIN_A
ARG WP_DB_PASSWORD_A
ARG WP_DB_PASSWORD_ROOT_A
ARG WP_DB_NAME_A

ENV WP_DB_LOGIN=$WP_DB_LOGIN_A
ENV WP_DB_PASSWORD=$WP_DB_PASSWORD_A
ENV WP_DB_PASSWORD_ROOT=$WP_DB_PASSWORD_ROOT_A
ENV WP_DB_NAME=$WP_DB_NAME_A

RUN apt-get update
RUN apt-get install -y mariadb-server

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools /var/www/

RUN sed -i "s/wp_user_to_remove/$WP_DB_LOGIN/" /var/www/initial_db.sql
RUN sed -i "s/wp_password_to_remove/$WP_DB_PASSWORD/" /var/www/initial_db.sql
RUN sed -i "s/wp_password_root_to_remove/$WP_DB_PASSWORD_ROOT/" /var/www/initial_db.sql
RUN sed -i "s/wp_db_name_to_remove/$WP_DB_NAME/" /var/www/initial_db.sql
RUN cat /var/www/initial_db.sql
RUN service mysql start && mysql < /var/www/initial_db.sql && rm -f /var/www/initial_db.sql;

CMD ["mysqld"]