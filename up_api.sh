#!/bin/bash

export PERLBREW_ROOT=/home/smm/perl5/perlbrew
source ${PERLBREW_ROOT}/etc/bashrc

fuser 3060/tcp -k
sleep 2

cd /home/smm/SMM/api

EMAIL_ADMIN=renan.azevedo.carvalho@gmail.com starman  -l :3060  --workers 8 --preload-app --error-log /home/smm/SMM/web/api.error.log --daemonize smm.psgi

