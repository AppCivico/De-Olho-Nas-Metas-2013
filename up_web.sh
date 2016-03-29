#!/bin/bash

source ~/perl5/perlbrew/etc/bashrc

fuser 5040/tcp -k
sleep 2

cd /home/donm/De-Olho-Nas-Metas/web

starman -l 127.0.0.1:5040 --workers 2 --preload-app --error-log /home/donm/logs/web.error.log --daemonize websmm.psgi
