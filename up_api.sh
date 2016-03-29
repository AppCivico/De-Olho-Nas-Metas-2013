#!/bin/bash

source ~/perl5/perlbrew/etc/bashrc

fuser 3060/tcp -k
sleep 2

cd /home/donm/De-Olho-Nas-Metas/api

sqitch deploy

EMAIL_ADMIN=your@email.com starman -l 127.0.0.1:3060 --workers 2 --preload-app --error-log /home/donm/logs/api.error.log --daemonize smm.psgi
