#!/bin/bash

#database configurations
# This user should only have "LOCK TABLES" and "SELECT" privileges for security purposes
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
