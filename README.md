# composer-build

Developer instructions to build the GSB Public Website using Composer in a local Lando/Docker container.

## Install Lando

* On Mac run the following command:

```
brew cask install lando
```

## Lando Composer Steps (draft)

* Clone this repo

```
git clone git@github.com:gsb-public/composer-build.git
```
* Edit composer-build/scripts/doimport.sh and doupdate.sh to match your specific setup

* Edit .lando.yml to point your composer-build/confd folder. This has the php.ini file that lando will use for your site.

* Create a new site directory
* cd into the your new site directory

```
mkdir newsite
cd newsite
```

* copy composer-build/.lando.yml into your new site directory

```
cp ~/Desktop/lando/composer-build/.lando.yml .
```

* start lando
* use composer to install drupal7 into the gsb directory

```
lando start
lando composer create-project drupal-composer/drupal-project:7.x-dev gsb --stability dev --no-interaction
```

* copy composer-build/composer.json into the gsb directory

```
cd gsb
cp ~/Desktop/lando/composer-build/composer.json .
```

* edit composer.json
* remove contents of require section of merge-plugin 

```
lando composer require
```

* copy composer.json again

```
cp ~/Desktop/lando/composer-build/composer.json .
lando composer require
```

* run database import script (you'll need to edit this a bit to point to a downloaded tar file)

```
sh ~/Desktop/lando/composer-build/scripts/doimport.sh
```

* run the patch docroot script

```
sh ~/Desktop/lando/composer-build/scripts/dopatchdoc.sh
```

* edit settings.php

```
vi sites/default/settings.php
```

* add under databases section

```
$databases = array (
  'default' => 
  array (
    'default' => 
    array (
      'database' => 'drupal7',
      'username' => 'drupal7',
      'password' => 'drupal7',
      'host' => 'database',
      'port' => '',
      'driver' => 'mysql',
      'prefix' => '',
    ),
  ),
);
```

* comment out require_once at top of webform_to_gdocs.module

```
vi profiles/gsb_public/modules/contrib/webform_to_gdocs/webform_to_gdocs.module
```

* move ctools_query_string_context

```
mkdir profiles/gsb_public/modules/custom/modules
mv profiles/gsb_public/modules/custom/ctools_query_string_context profiles/gsb_public/modules/custom/modules/.
```

* create temp directory - in gsb directory

```
mkdir temp
```

* comment out line 63 of memcache_admin.module

```
vi profiles/gsb_public/modules/contrib/memcache/memcache_admin/memcache_admin.module

The code should look like this when you're done.

 63     //if ($cluster = dmemcache_object_cluster($bin)) {
 64     if (true) {
 65       $name = $cluster['cluster'];
 66       $clusters[$name]['servers'][] = $server;
```

* try running drush

```
lando drush
```

* run the update script (you'll need to edit this to put in one of the development site urls)

```
sh ~/Desktop/composer/composer-build/scripts/doupdate.sh
```

* bounce lando app gsb

```
lando stop gsb
lando start gsb
```

## Setting up Debugging in PHPStorm

1) Open the Views/Tool Window/Docker pane
1) Click on the 'Environment Variables' menu at the top of the Docker pane.
1) Add the following variable/value pair:

```
XDEBUG_CONFIG=remote_enable=true remote_host=host.docker.internal
```

* Add the following to a url for a page on the GSB Public Web site served from your local Lando container:

```
?XDEBUG_SESSION=PHPSTORM
```

## Known issues

1) Library for scottjehl/respondjs is not unzipping the tar.gz file
1) profiles/gsb_public/libraries/markdown should be moved to be in profiles/gsb_public/libraries/markitup/markitup/sets/markdown

## Todos

1) Patches done in the composer.json of gsb custom modules are not being triggered to run. Added these patches directly into this main composer file - to 'fix' the issue for the moment. This needs to be resolved later.


