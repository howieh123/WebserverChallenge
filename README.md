# WebserverChallenge

Working on webserver challenge to automatically bring up a secure webserver in AWS and run some simple tests  
against it.  I was only able to get circleci to build and test the docker container due to some limitations   
on its ability to run ansible scripts to deploy (or perhaps my ignorance).  I used my own ansible scripts  
to deploy it and secure it 

# Dockerfile

Minimal nginx docker was chosen to host the static web page -- webservers hosting static content should be immutable  
and modified only through a new docker revision.  I copy the small html file, the SSL keys/cert and create SSL-default
so that it will redirect http to https.

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

file used by CircleCI to test  

# Docker.yml and UFW-playbook.yml

playbooks for creating docker on my AWS ec2 instance and for securing the ec2 host so that only port 22/80/443 are allowed to accept incoming connections.

# Deploy.sh

Script for running the above playbooks then starting the webserver when finished (i know I could have just added another ansible playbook, but its  
been a long day and its a one liner.
