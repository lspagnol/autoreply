#!/bin/bash

# Paquets indispensables
apt-get install mailutils diffutils

# Cache et configuration des répondeurs
for d in /var/lib/autoreply /var/cache/autoreply ; do
	[ -d ${d} ] || mkdir ${d}
	chown -R nobody:nogroup ${d}
	chmod 750 ${d}
done

# Configuration du robot répondeur
[ -d /etc/autoreply ] || mkdir /etc/autoreply
chown -R root:root /etc/autoreply
chmod 755 /etc/autoreply
[ -f /etc/autoreply/msg ] || cp etc/msg /etc/autoreply/msg
[ -f /etc/autoreply/autoreply.cf ] || cp etc/autoreply.cf /etc/autoreply/autoreply.cf
[ -f /etc/autoreply/help ] || cp USAGE.md /etc/autoreply/help

# Scripts
[ -d /usr/local/autoreply ] || mkdir /usr/local/autoreply
chown -R root:root /usr/local/autoreply
chmod 755 /usr/local/autoreply
cp bin/* /usr/local/autoreply
for f in config reply purge ; do
	chmod +x /usr/local/autoreply/${f}
done
ln -s /usr/local/autoreply/purge /etc/cron.hourly
