#!/bin/bash

yum install python-pip   
pip install virtualenv   
pip install --upgrade pip     
mkdir ~/newproject    
cd ~/newproject    
virtualenv newenv    
source newenv/bin/activate    
pip install django   
django-admin --version       
django-admin startproject newproject    
cd newproject    
python manage.py migrate      
echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@newprject.com', 'P@ssw0rd1')" | python manage.py shell      # < -work around this to add user 
myip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOST \[\'$myip\'\]/g" newprject/settings.py
python manage.py runserver 0.0.0.0:8000
