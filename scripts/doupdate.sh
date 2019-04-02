#!/usr/bin/env bash

PROJECT_DIR="."
DISTRO="gsb-public"
REMOTE_URL="<dev/dev2/stage/stage2 server url>"
SITES_DIR=$PROJECT_DIR/sites/default
TMP_DIR="temp"

sudo ln -s $SITES_DIR $PROJECT_DIR/sites/gsb

echo "Disable Memcache, Acquia and Shield"
lando drush dis -y memcache_admin acquia_purge acquia_agent shield

echo "Set site variables"
lando drush vset file_private_path $TMP_DIR
lando drush vset file_temporary_path $TMP_DIR
lando drush upwd --password=admin admin
lando drush vset cache 0
lando drush vset preprocess_css 0
lando drush vset preprocess_js 0
lando drush vset error_level 2

echo "Run database updates"
lando drush updb -y

echo "Revert features"
lando drush fra -y

echo "Enable Stage File Proxy and Devel"
lando drush en -y devel stage_file_proxy
lando drush vset stage_file_proxy_origin $REMOTE_URL

echo "Enable views development setup."
lando drush vd

echo "Clearing cache"
lando drush cc all

