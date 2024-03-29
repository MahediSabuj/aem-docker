#!/bin/bash

DISPARCH=x86_64

if [ "${TARGETARCH}" = "arm64" ]; then
    DISPARCH=aarch64
fi

#create default docroots
mkdir -p /mnt/var/www/html
chown apache:apache /mnt/var/www/html

mkdir -p /mnt/var/www/default
chown apache:apache /mnt/var/www/default

mkdir -p /mnt/var/www/author
chown apache:apache /mnt/var/www/author

#create and link up default enabled vhosts
mkdir /etc/httpd/conf.d/enabled_vhosts
ln -s /etc/httpd/conf.d/available_vhosts/aem_author.vhost /etc/httpd/conf.d/enabled_vhosts/aem_author.vhost
ln -s /etc/httpd/conf.d/available_vhosts/aem_flush_author.vhost /etc/httpd/conf.d/enabled_vhosts/aem_flush_author.vhost
ln -s /etc/httpd/conf.d/available_vhosts/aem_publish.vhost /etc/httpd/conf.d/enabled_vhosts/aem_publish.vhost
ln -s /etc/httpd/conf.d/available_vhosts/aem_flush.vhost /etc/httpd/conf.d/enabled_vhosts/aem_flush.vhost
ln -s /etc/httpd/conf.d/available_vhosts/aem_health.vhost /etc/httpd/conf.d/enabled_vhosts/aem_health.vhost

#create and link up default enabled farms
mkdir /etc/httpd/conf.dispatcher.d/enabled_farms
ln -s /etc/httpd/conf.dispatcher.d/available_farms/000_ams_catchall_farm.any /etc/httpd/conf.dispatcher.d/enabled_farms/000_ams_catchall_farm.any
ln -s /etc/httpd/conf.dispatcher.d/available_farms/001_ams_author_flush_farm.any /etc/httpd/conf.dispatcher.d/enabled_farms/001_ams_author_flush_farm.any
ln -s /etc/httpd/conf.dispatcher.d/available_farms/001_ams_publish_flush_farm.any /etc/httpd/conf.dispatcher.d/enabled_farms/001_ams_publish_flush_farm.any
ln -s /etc/httpd/conf.dispatcher.d/available_farms/002_ams_author_farm.any /etc/httpd/conf.dispatcher.d/enabled_farms/002_ams_author_farm.any
ln -s /etc/httpd/conf.dispatcher.d/available_farms/002_ams_publish_farm.any /etc/httpd/conf.dispatcher.d/enabled_farms/002_ams_publish_farm.any

#set up dispatcher
mkdir -p /tmp/dispatcher

curl -o /tmp/dispatcher/dispatcher.tar.gz https://download.macromedia.com/dispatcher/download/dispatcher-apache2.4-linux-$DISPARCH-4.3.5.tar.gz

cd /tmp/dispatcher

tar zxvf dispatcher.tar.gz

cp -v dispatcher-apache2.4-4.3.5.so /etc/httpd/modules/mod_dispatcher.so
