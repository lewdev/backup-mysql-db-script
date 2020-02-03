#!/bin/bash
#mysql start/running
#mysql stop/waiting
#crontab -e
#if [[ ! "$(service mysql status)" =~ "start/running" ]] && [[ ! "$(service mysql status)" =~ "stop/waiting" ]] && [[ ! "$(service mysql status)" =~ "/usr/bin/mysqladmin" ]]
UP=$(pgrep mysql | wc -l);
if [ "$UP" -ne 1 ];
then
    echo $(date +"%Y-%m-%d %H:%M") " Server was rebooted because MySQL isn't starting."
    reboot
fi
