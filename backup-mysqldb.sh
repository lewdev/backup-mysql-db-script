#!/bin/bash
rm /path/to/backup/sql-backup-lastmonth.zip 

mv /path/to/backup/sql-backup-thismonth.zip /path/to/backup/sql-backup-lastmonth.zip

mysqldump --user=[username] --password=[password] --databases [dbname] > sql-backup-$(date +\%Y\%m\%d).sql

zip -q /path/to/backup/sql-backup-thismonth.zip sql-backup-$(date +\%Y\%m\%d).sql 

rm sql-backup-$(date +\%Y\%m\%d).sql 
