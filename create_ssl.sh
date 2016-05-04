docker run -v $PWD:/ssl -it nginx openssl genrsa -des3 -out /ssl/server.key.protected 2048
docker run -v $PWD:/ssl -it nginx openssl req -new -key /ssl/server.key.protected -out /ssl/server.csr
docker run -v $PWD:/ssl -it nginx openssl rsa -in /ssl/server.key.protected -out /ssl/server.key
docker run -v $PWD:/ssl -it nginx openssl x509 -req -days 365 -in /ssl/server.csr -signkey /ssl/server.key -out /ssl/server.crt
