FROM nginx:latest

COPY nginx.conf /etc/nginx/
COPY templates /etc/nginx/templates/
RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN mkdir -p /etc/ssl/certs/dhparam && openssl dhparam -out /etc/ssl/certs/dhparam/dhparam-2048.pem 2048

EXPOSE 80
EXPOSE 443