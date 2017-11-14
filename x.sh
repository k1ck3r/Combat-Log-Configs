#!/bin/bash

file="/var/lib/multistreamer/.postgres-auth-server/logs/nginx.pid"

if [ -f "$file" ]
then
	echo "gg"
else
	systemctl start postgres-auth-server.service
fi
