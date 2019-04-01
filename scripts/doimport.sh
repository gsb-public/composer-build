#!/usr/bin/env bash

gunzip -c ~/Sites/gsb2/dump.sql.gz > out.sql
lando db-import out.sql 
