#!/bin/bash
IONCUBE_VERSION=`php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;"`
EXT_DIR=`php -i | grep extension_dir | cut -d' ' -f3`;
PHP_CONFIG=/etc/php5/conf.d/

cd /tmp/

if [ ! -f ioncube_loaders_lin_x86-64.tar.gz ]; then
	wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
fi

if [ ! -f ${EXT_DIR}/ioncube_loader_lin_${IONCUBE_VERSION}.so ]; then
	tar -xzvf  ioncube_loaders_lin_x86-64.tar.gz
	cd ioncube
	cp ioncube_loader_lin_${IONCUBE_VERSION}.so ${EXT_DIR}/
fi

STRING="zend_extension=${EXT_DIR}/ioncube_loader_lin_${IONCUBE_VERSION}.so"

if [ ! -f ${PHP_CONFIG}ioncube.ini ]; then
	echo ${STRING} > ${PHP_CONFIG}ioncube.ini
fi
	
exit 0