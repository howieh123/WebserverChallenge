# WebserverChallenge

Working on webserver challenge to automatically bring up a secure webserver in AWS and run some simple tests  
against it.

# Dockerfile

Minimal nginx docker was chosen to host the static web page -- webservers hosting static content should be immutable  
and modified only through a new docker revision

# create_ssl.sh 

Shell script to create the selfsigned SSL certificate and key, using the nginx based docker container to run the needed openssl commands

    docker run -v $PWD:/ssl -it nginx openssl genrsa -des3 -out /ssl/server.key.protected 2048
    docker run -v $PWD:/ssl -it nginx openssl req -new -key /ssl/server.key.protected -out /ssl/server.csr
    docker run -v $PWD:/ssl -it nginx openssl rsa -in /ssl/server.key.protected -out /ssl/server.key
    docker run -v $PWD:/ssl -it nginx openssl x509 -req -days 365 -in /ssl/server.csr -signkey /ssl/server.key -out /ssl/server.crt

# DockerBuild.sh and DockerRun.sh

used the directory for the docker name, got tired of typing these commands into the shell during testing

    docker build -t ${PWD##*/} .

    docker run -d -p 80:80 -p 443:443 ${PWD##*/}

# circle.yml 

file used by CircleCI to test and then deploy on changes to Git source. 
