# PiBackup
Minimalistic backup script to backup the complete Raspberry Pi using rsync


# Motivation 
The script was copied from an answer to
http://raspberrypi.stackexchange.com/questions/5427/can-a-raspberry-pi-be-used-to-create-a-backup-of-itself

Direct link:
http://raspberrypi.stackexchange.com/a/28087

The approach of using rsync instead of using dd fits better to my use case.
I already have a remote rsync server running on a Synology NAS.

I also want to run the script as cronjob - dd would be too expensive in terms of HDD space and is also not capable of doing incremental backups.
