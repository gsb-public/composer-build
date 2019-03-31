# composer-build

This is just a rough start at creating a composer.json file for our GSB Public Site.

## Build Steps

1) Run the following create-project command
```
composer create-project drupal-composer/drupal-project:7.x-dev gsb --stability dev --no-interaction
```

2) Change directory to the new project:
```
cd gsb
```

3) Copy composer-build/composer.json (from this repository) over the composer.json in gsb/

4) Run the composer require command:
```
composer require
```

## Known issues

1) Library for scottjehl/respondjs is not unzipping the tar.gz file
1) profiles/gsb_public/libraries/markdown should be moved to be in profiles/gsb_public/libraries/markitup/markitup/sets/markdown

## Todos

1) Patches done in the composer.json of gsb custom modules are not being triggered to run. Added these patches directly into this main composer file - to 'fix' the issue for the moment. This needs to be resolved later.

## Lando Steps (draft)

* webroot = web
* app name = gsb2

```
lando init
```

```
lando start
lando composer create-project drupal-composer/drupal-project:7.x-dev gsb2 --stability dev --no-interaction
```

```
cd gsb2
cp ~/Desktop/composer/class/d7-gsb2/composer.json .
```

* edit composer.json
* remove contents of require section of merge-plugin 

```
lando composer require
```

* edit composer.json 
* add back merge-plugin require for extra sub-level composer.json files

```
lando composer require
```

```
sh ~/Desktop/lando/scripts/doimport.sh
use drupal7;
source out.sql
```

```
mv web/* .
mv web/.* .
```

edit settings.php

```
vi sites/default/settings.php
```

add under databases section

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
