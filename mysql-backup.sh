#!/bin/bash

# Example Usage:
#  > chmod u+x backup-mysql-db-script.sh
#  > ./backup-mysql-db-script.sh daily

# 0. Install zip.
#  > sudo apt-get install zip

# 1. Create a MySQL backup user with limited access to each database you want to back up.
#  > mysql -u root -p
#  > CREATE USER 'backup_user'@'localhost' IDENTIFIED BY 'STRONGPASSWORD';
#  > GRANT SELECT,LOCK TABLES ON databse-a.* TO 'backup_user'@'localhost';

# 2. Set database configurations below:
DB_USER=""
DB_PASS=""
DB_HOST="" #usually just 'localhost'
BASE_DIR="/path/to/backup/dir"
DB_NAMES=('database-a' 'database-b' 'database-c' )

#default file postfixes
NOWNAME="now"
BEFORENAME="before"
case "$1" in
    'daily')
        NOWNAME="today"
        BEFORENAME="yesterday"
    ;;
    'weekly')
        NOWNAME="thisweek"
        BEFORENAME="lastweek"
    ;;
    'monthly')
        NOWNAME="thismonth"
        BEFORENAME="lastmonth"
    ;;
esac

#current date/time YYY-MM-DD-hhmm
NOW=$(date +"%Y-%m-%d-%H%M")

for DB_NAME in "${DB_NAMES[@]}"; do
    #output directory
    OUTPUT_DIR="$BASE_DIR/$DB_NAME"

    #create the DB directory if it doesn't exist
    if [ ! -d $OUTPUT_DIR ]; then
        mkdir $OUTPUT_DIR
    fi

    #delete "before" zip
    if [ -f $OUTPUT_DIR/$DB_NAME.sql.$BEFORENAME.zip ]; then
        rm $OUTPUT_DIR/$DB_NAME.sql.$BEFORENAME.zip
    fi

    #rename "now" zip to "before" zip
    if [ -f $OUTPUT_DIR/$DB_NAME.sql.$NOWNAME.zip ]; then
        mv $OUTPUT_DIR/$DB_NAME.sql.$NOWNAME.zip $OUTPUT_DIR/$DB_NAME.sql.$BEFORENAME.zip
    fi

    #mysqldump sql script
    mysqldump --user=$DB_USER --password=$DB_PASS --databases $DB_NAME > $DB_NAME.$NOW.sql

    if [ -f $DB_NAME.$NOW.sql ]; then
        #zip to now zip
        zip -q $OUTPUT_DIR/$DB_NAME.sql.$NOWNAME.zip $DB_NAME.$NOW.sql

        #delete mysql dump file
        rm $DB_NAME.$NOW.sql
    fi
done
