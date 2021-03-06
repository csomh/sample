FROM centos:latest

# Add our user and group first to make sure their IDs get assigned consistently,
# regardless of whatever dependencies get added.
# Found at https://github.com/gencat/httpd-openshift/blob/master/Dockerfile
# RUN groupadd -r apache && useradd -r -g apache apache

RUN yum -y update \
    && yum -y install epel-release \
    && yum -y install --setopt=tsflags=nodocs \
        httpd mod_wsgi python-gunicorn python-pip \
    && yum -y clean all

#Copying apache config file to apt folder
# COPY django.conf /etc/httpd/conf.d/

#Copying django application code in to /home/ directory
COPY sample /home/

# COPY docker-setup.sh /
# RUN chmod 0755 /docker-setup.sh \
#     && /docker-setup.sh \
#     && rm -f /docker-setup.sh

# COPY httpd-foreground /bin/httpd-foreground
# RUN chmod 0755 /bin/httpd-foreground
#installing pip
# RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
# RUN python get-pip.py

# #installing django
RUN pip install django
RUN python /home/sample/manage.py migrate

#RUN httpd -k restart
#RUN cd /home/
#RUN django-admin startproject sample

EXPOSE 8080

ENTRYPOINT gunicorn --bind 0.0.0.0:8080 --access-logfile=- --pythonpath /home/sample sample.wsgi
#ENTRYPOINT ["sleep","999999999"]
#ENTRYPOINT ["python /home/sample/manage.py runserver 8080"]
