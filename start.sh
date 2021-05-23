#!/bin/bash
apt-get update
apt-get -y safe-upgrade

# initialize trap to forceful stop the bot
trap terminator SIGHUP SIGINT SIGQUIT SIGTERM
function terminator() { 
  echo 
  echo "Shutting down jottad $child..."
  stop
  kill -TERM "$child" 2>/dev/null
  echo "Exiting."
}

function stop() {
    /etc/init.d/jottad stop
}

function start() {
    /etc/init.d/jottad start
}

function update() {
    apt-get update
    apt-get -y upgrade
}

echo "OS Date: $(date)"

echo "Starting jottad"
start
#sleep 10 # we need to wait till the serviceisstarted before weare able to get the log path (ugly but the only way at the moment)
#tail -f "$(jotta-cli logfile)" &
tail -f /var/lib/jottad/jottabackup.log &

child=$!
wait "$child"