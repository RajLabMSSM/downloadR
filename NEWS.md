# downloadR 0.99.3

## New features

* New check functions:
    + `downloader_check_method`
    + `check_avail`
* Optionally tool executable paths to `axel` and `wget`, to reduce the number
of times `echoconda::find_packages` is run. 

## Bug fixes

* Fix `echoconda::find_packages` (now that this returns a data.table).


# downloadR 0.99.2

## Bug fixes

* Update `echoconda` function name: `env_from_yaml` --> `yaml_to_env`


# downloadR 0.99.1

## New features

* Update GHA.
* Update `echoconda::findpackage` --> `echoconda::findpackages`
* Add hex sticker. 
* Update README template.
* Remove *docs/*.


# downloadR 0.99.0

## New features

* Added a `NEWS.md` file to track changes to the package.
* Added axel, wget, and download.file as methods. 