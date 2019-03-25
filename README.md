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
1) Libraries and modules from other .make files not getting added. Example weather not being added to profiles/gsb_public/libraries folder.
