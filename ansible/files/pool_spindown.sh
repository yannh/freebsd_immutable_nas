#!/usr/local/bin/zsh
setopt sh_word_split

PATH=/usr/local/bin:/bin:/usr/bin:/usr/sbin:/usr/local/sbin:/bin:/sbin
export PATH

ZPOOL="pool"
SMBSHARE="DEPOT"

# Get drives for pool
drives=`zpool status $ZPOOL | egrep "da[0123456789][^p]" | awk '{print $1}' | tr '\n' ' '`
firstdrive=`echo "$drives" | awk '{print $1}'`

# Activity checks
smbactive=`smbstatus -S | grep -A 6 "Connected at" | grep $SMBSHARE | wc -l | awk '{print $NF}'`
scrubrunning=`zpool status $ZPOOL | egrep "scrub in progress|resilver in progress" | wc -l | awk '{print $NF}'`
spundown=`smartctl -n sleep -H /dev/$firstdrive | tail -1 | grep "SLEEP" | wc -l | awk '{print $NF}'`

if [ $smbactive -gt 0 ] ; then
  echo "Samba share is mounted...Aborting spindown"
  exit 3
elif [ $scrubrunning -eq 1 ] ; then
  echo "Scrub/resilver is running...Aborting spindown"
  exit 3
elif [ $spundown -eq 1 ] ; then
  echo "Spundown already...Aborting spindown"
  exit 3
fi

# Longer IO Activity check - only perform if got past above

# Cleanup any tmp file if present
[[ -f /tmp/zpool.iostat ]] && rm -f /tmp/zpool.iostat
zpool iostat $ZPOOL 60 2 | tail -1 > /tmp/zpool.iostat
reading=`awk '{print $(NF-1)}' /tmp/zpool.iostat | awk -F\. '{print $1}' | sed -e 's/K//g' | sed -e 's/M//g'`
writing=`awk '{print $NF}' /tmp/zpool.iostat | awk -F\. '{print $1}' | sed -e 's/K//g' | sed -e 's/M//g'`
rm -f /tmp/zpool.iostat

if [ $reading -gt 0 ] ; then
  echo "Pool shows IO activity...Aborting spindown"
  exit 3
elif [ $writing -gt 0 ] ; then
  echo "Pool shows IO activity...Aborting spindown"
  exit 3
fi

for drive in $drives ; do
  camcontrol sleep $drive
  printf "Spindown Drive %s\n" $drive
done
