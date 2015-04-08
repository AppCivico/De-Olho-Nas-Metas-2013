#!/usr/bin/env bash

if [ -d "script" ]; then
  cd script;
fi

perl smm_create.pl model DB DBIC::Schema SMM::Schema create=static components=TimeStamp,PassphraseColumn 'dbi:Pg:dbname=smm;host=localhost' postgres 123mudar quote_names=1 overwrite_modifications=1

cd ..;

rm lib/SMM/Model/DB.pm.new;
rm t/model_DB.t.new;
