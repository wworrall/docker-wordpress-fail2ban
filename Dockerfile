# Installs and configures fail2ban on top of wordpress:latest image
# NOTE: The resulting container must be run with elevated privileges in order to
# use command `iptables'.

FROM wordpress:latest

# needed for installation and configuration of fail2ban
RUN apt-get update; \
apt-get upgrade; \
apt-get install -y \
apt-utils \
wget \
unzip \
python \
rsyslog \
fail2ban;

COPY ./bin/wp-fail2ban-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-fail2ban-setup.sh

# execute wp-fail2ban-setup before apache2-foreground from wordpress image
CMD ["sh", "-c", "wp-fail2ban-setup.sh; apache2-foreground"]
