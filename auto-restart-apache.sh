#!/bin/sh

ps auxw | grep apache2 | grep -v grep > /dev/null

if [ $? != 0 ]
then
    /etc/init.d/apache2 start > /dev/null
    echo $(date +"%Y-%m-%d %H:%M") " Apache was restarted" >> /var/www/scripts/scripts-executed.log
fi
