#!/bin/bash
echo "start jottacloud commandline"
echo "OS Date: $(date)"

# check for updates (this also keeps jottacloud up2date after each start)
echo "checking for updates"
apt-get update
apt-get -y upgrade

# we need to make sure that the service is not running or starting in the background (after each update)
echo "stopping and disabling default service (this could produce errors - just ignore them)"
/etc/init.d/jottad stop
update-rc.d jottad disable
update-rc.d jottad remove

# starting
echo "starting jottad (to see logs open the 'jottabackup.log' file inside the mounted volume)"
/usr/bin/jottad