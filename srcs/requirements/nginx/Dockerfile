FROM debian:buster

ARG WP_URL_A
ARG WP_PERSO_URL_A
ARG WP_AD_URL_A
ENV WP_URL=$WP_URL_A
ENV WP_PERSO_URL=$WP_PERSO_URL_A
ENV WP_AD_URL=$WP_AD_URL_A

RUN apt-get update
RUN apt-get install -y nginx openssl

EXPOSE 443

COPY ./conf/default /etc/nginx/sites-enabled/default

RUN openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=FR/ST=Lyon/L=Lyon/O=wordpress/CN=${WP_URL}"

RUN sed -i "s/host_to_remove/${WP_URL}/" /etc/nginx/sites-enabled/default && sed -i "s/host_ad_to_remove/${WP_AD_URL}/" /etc/nginx/sites-enabled/default && sed -i "s/host_perso_to_remove/${WP_PERSO_URL}/" /etc/nginx/sites-enabled/default

CMD ["nginx", "-g", "daemon off;"]
