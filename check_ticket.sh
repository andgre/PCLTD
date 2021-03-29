#!/bin/sh
while true
do
        /var/www/html/send_notification_rocketchat.php
        sleep 5
#       echo "Press [CTRL+C] to stop.."    sleep 1
done
