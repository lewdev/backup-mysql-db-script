backup-mysql-db-script
======================

This script is designed to be easy to configure and back up your MySQL databases on a daily, weekly, and monthly with the combination of bash and cron. I have seen solutions online where the back up is only once, but this will keep a current and save the previous back up.

Configurations
==============
    DB_USER=""
    DB_PASS=""
    DB_HOST=""
    BASE_DIR="/path/to/backup/dir"
    DB_NAMES=('database-a' 'database-b' 'database-c' )

BASE_DIR is where you will store your back up data.

If you use different users for each database, create a "backup" user with "LOCK TABLES" and "SELECT" privileges only so that the script is a bit safer to use.

USAGE
=====
./mysql-backup.sh daily

You may use 'daily', 'weekly', or 'monthly' as the first argument to have the following result:

    # "daily"
    /path/to/backup/dir/database-a.sql.today.zip
    /path/to/backup/dir/database-a.sql.yesterday.zip

    # "weekly"
    /path/to/backup/dir/database-a.sql.lastweek.zip
    /path/to/backup/dir/database-a.sql.thisweek.zip

    # "monthly"
    /path/to/backup/dir/database-a.sql.lastmonth.zip
    /path/to/backup/dir/database-a.sql.thismonth.zip


Set up cron to run the command on a daily, weekly, and monthly basis and you are set!