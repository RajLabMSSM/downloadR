# downloadR 0.99.5

## New features

* Zenodo functions:
    - `zenodo_list`
    - `zenodo_upload`
* Figshare function:
    - `figshare_links`
* `downloader`:
    - Can now takes lists of files
    - Made subfunction `downloader_one`
* Passing all CRAN checks locally.  

## Bug fixes

* Fix GHA: @master --> @v2  
* Change `conda_env`: "echoR" --> "echoR_mini"

# downloadR 0.99.4

## New features

* Default is now `nThread=1`.
* Ensure existing files get sent back immediately. 
* `load_rdata`: Extend to local/remote rda/rds files. 
* `validate_file`: New function to validate file presence and size. 
* `downloader`: New arg `retry_method`.

## Bug fixes

* Reassign `output_path` to appropriate new arg `output_dir`.
* Update README badges.


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