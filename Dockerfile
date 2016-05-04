FROM kyma/docker-nginx
COPY src/ /var/www
COPY ssl/ /etc/nginx/ssl/
COPY cfg/default-ssl /etc/nginx/sites-available/default-ssl
RUN ln -s /etc/nginx/sites-available/default-ssl /etc/nginx/sites-enabled/default-ssl
CMD ["/usr/sbin/nginx"]
