#!/bin/bash

# setup directory for data
mkdir -p /data
chown -R httpd:0 /data
chmod g+w -R /data
chown -R httpd:0 /run/httpd
chown -R httpd:0 /var

chgrp -R 0 /run/httpd
chmod -R g+rw /run/httpd
find /run/httpd -type d -exec chmod g+x {} +

chgrp -R 0 /var
chmod -R g+rw /var
find /var -type d -exec chmod g+x {} +
