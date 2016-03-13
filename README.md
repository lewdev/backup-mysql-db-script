backup-mysql-db-script
======================

This script is designed to be easy to configure and back up your MySQL databases on a daily, weekly, and monthly with the combination of bash and cron. I have seen solutions online where the back up is only once, but this will keep a current and save the previous back up.

The "zip" command is required, so instal it using:

    > sudo apt-get install zip

Configurations
==============
Apply appropriate configurations at the top of the script:

    DB_USER=""
    DB_PASS=""
    DB_HOST=""
    BASE_DIR="/path/to/backup/dir"
    DB_NAMES=('database-a' 'database-b' 'database-c' )

BASE_DIR is where you will store your back up data.

If you use different users for each database, create a "backup" user with "LOCK TABLES" and "SELECT" privileges only so that the script is a bit safer to use.

USAGE
=====
You may use 'daily', 'weekly', or 'monthly' as the first argument to use the appropriate naming convention for the zip file.

    ./mysql-backup.sh daily

    ./mysql-backup.sh weekly

    ./mysql-backup.sh monthly

    # "daily"
    /path/to/backup/dir/database-a.sql.today.zip
    (database-a.2014-07-08-2047.sql)
    /path/to/backup/dir/database-a.sql.yesterday.zip
    (database-a.2014-07-07-2047.sql)

    # "weekly"
    /path/to/backup/dir/database-a.sql.lastweek.zip
    (database-a.2014-07-01-2047.sql)
    /path/to/backup/dir/database-a.sql.thisweek.zip
    (database-a.2014-07-08-2047.sql)

    # "monthly"
    /path/to/backup/dir/database-a.sql.lastmonth.zip
    (database-a.2014-06-08-2047.sql)
    /path/to/backup/dir/database-a.sql.thismonth.zip
    (database-a.2014-07-08-2047.sql)


Setup cron jobs
===============
Type the following command in your Ubuntu installation prompt:

    > crontab -e

In the cron config file, put in scheduled the following commands:

    # Daily 1:30 AM
    30 1 * * * /path-to-scripts/backup-mysql-database.sh daily

    # Weekly 1:40 AM
    40 1 * * 0 /path-to-scripts/backup-mysql-database.sh weekly

    # Monthly 1:50 AM
    50 1 3 * * /path-to-scripts/backup-mysql-database.sh monthly
