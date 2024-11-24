# base image changed to alpine: 1.21 version is from 2021, security concerns as well as various bugfixes. alpine is smaller image, eliminating unnecessary packages that come with the standard Debian-based nginx image
FROM nginx:alpine
# add openssl in order for the generate cert script to work as intended
RUN apk add --no-cache openssl

COPY 40-generate-cert.sh /docker-entrypoint.d/
COPY 41-get-404-page.sh /docker-entrypoint.d/

RUN chmod +x /docker-entrypoint.d/40-generate-cert.sh
RUN chmod +x /docker-entrypoint.d/41-get-404-page.sh

COPY nginx.conf /etc/nginx/

RUN mkdir -p /var/www/nginx/errors

ENV NGINX_ENTRYPOINT_QUIET_LOGS=1
