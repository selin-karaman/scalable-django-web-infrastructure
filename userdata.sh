#!/bin/bash
export ALLOWED_HOSTS="*"

apt-get update -y
apt-get install git -y
apt-get install python3 -y

systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

cd /home/ubuntu/

git clone https://github.com/selin-karaman/scalable-django-web-infrastructure.git

cd /home/ubuntu/scalable-django-web-infrastructure
apt install python3-pip -y
apt-get install python3.7-dev libmysqlclient-dev -y
pip3 install -r requirements.txt

cd /home/ubuntu/scalable-django-web-infrastructure/src
python3 manage.py collectstatic --noinput
python3 manage.py makemigrations
python3 manage.py migrate

nohup python3 manage.py runserver 0.0.0.0:80 > /home/ubuntu/django_run.log 2>&1 &