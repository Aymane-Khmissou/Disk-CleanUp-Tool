#!/bin/bash

# ===============================================
#           Automated Disk Space Cleaner
# ===============================================

MAX=80

LOG=cleanup.log

LOG_MSS() {
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG"
}

CURRENT=$(df / | grep / | awk {'print $5'} | tr -d '%')

if [ "$CURRENT" -ge "$MAX" ]
then
	LOG_MSS "WARNING: Disk storage is high!"
	sudo rm -rf /tmp/*
else
	LOG_MSS "Disk storage normal"
fi
