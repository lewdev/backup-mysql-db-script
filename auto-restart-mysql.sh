#!/bin/bash
#mysql start/running
#mysql stop/waiting
#crontab -e

#if [[ ! "$(service mysql status)" =~ "start/running" ]] && [[ ! "$(service mysql status)" =~ "stop/waiting" ]] && [[ ! "$(service mysql status)" =~ "/usr/bin/mysqladmin" ]]
UP=$(pgrep mysql | wc -l);
if [ "$UP" -ne 1 ];
then
    service mysql status
    service mysql start
    sudo tail -30 /var/log/mysql.err
    echo $(date +"%Y-%m-%d %H:%M") " MySQL was restarted" >> /var/www/scripts/scripts-executed.log
fi