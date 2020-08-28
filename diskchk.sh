#!/bin/sh
rm -rf DiskspaceCheck.txt
Mount=`df -h |grep "/$" | awk '{print $(NF-1)}' | tr -d '%'`
Max_Mount=80
if [ $Mount -gt $Max_Mount ]; then
echo "Mount Point has reached $Mount% and crossed the 80% threshold in server $HOSTNAME" >> DiskspaceCheck.txt
df -h >> DiskspaceCheck.txt
./newdiskspacecheck.py
fi

