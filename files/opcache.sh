#!/bin/bash
PHP_CONFIG=/etc/php5/conf.d/
OPCACHE_MEMORY_CONSUMPTION=$1
OPCACHE_ENABLE_CLI=$2
OPCACHE_REVALIDATE_FREQ=$3
OPCACHE_MAX_ACCELERATED_FILES=$4
OPCACHE_VERSION=$5

# check if opcache has been install
OPCACHE_ENABLED=`php -v |grep "with Zend OPcache"`

if [ ${#OPCACHE_ENABLED} > 1 ]; then
	pecl install zendopcache-7.0.4
fi

OPCACHE_INI=${PHP_CONFIG}opcache.ini
SO_LOCATION=`sudo find / -name 'opcache.so'`
	
if [ ! -f ${OPCACHE_INI} ]; then
	touch ${OPCACHE_INI}
	# find opcache.so location
	echo "zend_extension=${SO_LOCATION}" >> ${OPCACHE_INI}
	echo "opcache.memory_consumption=${OPCACHE_MEMORY_CONSUMPTION}" >> ${OPCACHE_INI}
	echo "opcache.interned_strings_buffer=8" >> ${OPCACHE_INI}
	echo "opcache.max_accelerated_files=${OPCACHE_MAX_ACCELERATED_FILES}" >> ${OPCACHE_INI}
	echo "opcache.revalidate_freq=${OPCACHE_REVALIDATE_FREQ}" >> ${OPCACHE_INI}
	echo "opcache.fast_shutdown=1" >> ${OPCACHE_INI}
	echo "opcache.enable_cli=${OPCACHE_ENABLE_CLI}" >> ${OPCACHE_INI}
fi


