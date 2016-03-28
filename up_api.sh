#!/bin/bash

export PERLBREW_ROOT=/home/smm/perl5/perlbrew
source ${PERLBREW_ROOT}/etc/bashrc

fuser 3060/tcp -k
sleep 2

cd /home/smm/SMM/api

EMAIL_ADMIN=your@email.com starman  -l :3060  --workers 2 --preload-app --error-log /home/smm/SMM/web/api.error.log --daemonize smm.psgi

