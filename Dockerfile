FROM nginx

COPY conf.d /etc/nginx/conf.d

RUN apt-get update && apt-get install -y wget cron && apt-get clean
RUN wget -O /opt/certbot-auto https://dl.eff.org/certbot-auto \
    && chmod +x /opt/certbot-auto \
    && /opt/certbot-auto --os-packages-only --noninteractive \
    && apt-get clean

ADD certbot_crontab /etc/cron.d/certbot_crontab
RUN chmod 0644 /etc/cron.d/certbot_crontab && crontab /etc/cron.d/certbot_crontab

ADD run.sh /root/run.sh


CMD ["/root/run.sh"]
