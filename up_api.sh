#!/bin/bash

export PERLBREW_ROOT=/home/smm/perl5/perlbrew
source ${PERLBREW_ROOT}/etc/bashrc

fuser 3060/tcp -k
sleep 2

cd /home/smm/SMM/api

starman  -l :3060  --workers 2 --preload-app --error-log /home/smm/SMM/web/api.error.log --daemonize smm.psgi

