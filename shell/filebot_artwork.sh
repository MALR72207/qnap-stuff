#!/bin/bash
#log
log_location=/share/Container/script/logs/artwork.log
touch $log_location
#Just run filebot artwork downloader on all files less than 1 day old
filebot.sh -script fn:artwork.tmdb --def maxAgeDays=1 /share/HD/ >> $log_location &
pid=$!
MaxFileSize=5242880
while kill -0 $pid 2> /dev/null; do
        #Get size in bytes** 
        file_size=`du -b $log_location | tr -s '\t' ' ' | cut -d' ' -f1`
        if [ $file_size -gt $MaxFileSize ];then   
            timestamp=`date +%F`
            mv $log_location $log_location.$timestamp
            touch $log_location
        fi
        sleep 1
done                                                                                                                       