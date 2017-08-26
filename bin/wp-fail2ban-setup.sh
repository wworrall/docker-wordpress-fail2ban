#!/bin/bash

# Install WP fail2ban plugin from: https://downloads.wordpress.org/plugin/wp-fail2ban.3.5.3.zip
# Set up WP fail2ban from instructions at:
# https://www.upcloud.com/support/installing-fail2ban-on-debian-8-0/
# https://en-gb.wordpress.org/plugins/wp-fail2ban/#installation
# NOTE: WP fail2ban plugin must also be activated from wordpress admin panel

/bin/cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local;

wget  -O ./wp-content/plugins/wp-fail2ban.3.5.3.zip "https://downloads.wordpress.org/plugin/wp-fail2ban.3.5.3.zip";
unzip ./wp-content/plugins/wp-fail2ban.3.5.3.zip -d ./wp-content/plugins/;
rm ./wp-content/plugins/wp-fail2ban.3.5.3.zip;

/bin/cp -rf wp-content/plugins/wp-fail2ban/filters.d/wordpress-*.conf \
/etc/fail2ban/filter.d;

JAIL_WP_CONF=$'
[wordpress-hard]
enabled = true
filter = wordpress-hard
logpath = /var/log/auth.log
maxretry = 1
port = http,https

[wordpress-soft]
enabled = true
filter = wordpress-soft
logpath = /var/log/auth.log
maxretry = 3
port = http,https';

echo "$JAIL_WP_CONF" >> /etc/fail2ban/jail.local;

# create necessary logfiles (add as needed)
touch /var/log/auth.log;
chown root:adm /var/log/auth.log;

# start services
/etc/init.d/rsyslog start;
/etc/init.d/fail2ban start;
