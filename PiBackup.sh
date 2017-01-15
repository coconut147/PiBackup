#!/bin/bash
# script to synchronise Pi files to backup


backup_destination=root@BigData::homes/GitPi/
logfilename=/GitStorage/_backup/logs/$(date +%Y_%m_%d_%H%M)_backup.log

echo "***** Backup of Raspberry started *****" >> $logfilename

rsync -avHP --delete-during --delete-excluded -e ssh --exclude-from=exclude.txt / $backup_destination/GitPi_Backup >> $logfilename 2>>$logfilename.err
echo "***** Backup finished *****" >> $logfilename

date >> $logfilename


# Before we can Backup the external storage mounted at /GitStorage - we should check if it is actually mounted

BACKUP_MOUNTED=$(mount | awk '/GitStorage/ {print $6}' | grep "rw")
if [ $BACKUP_MOUNTED ]; then
    echo "Commencing Backup"
    echo "***** Backup of GitStorage started *****" >> $logfilename
    rsync -v -P -r --delete -e ssh /GitStorage/ $backup_destination/GitStorage_Backup >> $logfilename 2>>$logfilename.err
    echo "***** Backup finished *****" >> $logfilename
    date >> $logfilename
else
    echo "Attention ! - GitStorage not available!"
    echo "/GitStorage/ not available or not writable" >> $logfilename.err
fi


# Let's zip the logfile
gzip $logfilename


exit 0

