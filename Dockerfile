FROM kyma/docker-nginx
COPY src/ /var/www
COPY ssl/ /etc/nginx/ssl/
COPY ./default /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/default-ssl /etc/nginx/sites-enabled/default-ssl
CMD 'nginx'
