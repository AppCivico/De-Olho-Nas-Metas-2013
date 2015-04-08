#!/bin/bash

export PERLBREW_ROOT=/home/smm/perl5/perlbrew
source ${PERLBREW_ROOT}/etc/bashrc

fuser 5040/tcp -k
sleep 2

cd /home/smm/SMM/web

starman  -l :5040  --workers 8 --preload-app --error-log /home/smm/SMM/web.error.log --daemonize websmm.psgi

