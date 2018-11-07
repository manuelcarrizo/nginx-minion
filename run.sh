#!/bin/bash

crontab /etc/cron.d/certbot_crontab

/etc/init.d/cron start

(sleep 10 && /opt/certbot-auto --nginx --email manuelcarrizo@gmail.com --agree-tos --noninteractive --no-bootstrap -d $(cat /etc/nginx/conf.d/*.conf | grep -Poe 'server_name \K[^; ]+' |  paste -sd "," -) ) &

echo "starting nginx"
nginx -g "daemon off;"