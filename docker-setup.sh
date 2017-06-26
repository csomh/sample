#!/bin/bash

# setup directory for data
mkdir -p /data
chown -R apache:0 /data
chmod g+w -R /data
chown -R apache:0 /run/httpd
chown -R apache:0 /var
chown -R apache:0 /home/sample

chgrp -R 0 /run/httpd
chmod -R g+rw /run/httpd
find /run/httpd -type d -exec chmod g+x {} +

chgrp -R 0 /var
chmod -R g+rw /var
find /var -type d -exec chmod g+x {} +
