ansible-playbook ./playbooks/docker-playbook.yml && ansible-playbook ./playbooks/ufw-playbook.yml && ansible tag_class_webserver -s -m command -a "docker run -d -p 80:80 -p 443:443 howieh123/webserverchallenge:latest"