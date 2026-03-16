# Zenodo upload

Search for files and then upload them to Zenodo.

## Usage

``` r
zenodo_upload(
  files,
  token = Sys.getenv("zenodo_token"),
  title,
  zipfile = file.path(tempdir(), title),
  meta = list(title = title, description = "", uploadType = "dataset", Creator =
    list(firstname = "", lastname = "", affiliation = "")),
  sandbox = TRUE,
  validate = TRUE,
  verbose = TRUE
)
```

## Source

` #### Installing zen4R #### ## has some system deps that have to be installed beforehand. sudo apt-get install raptor2-utils sudo apt-get install rasqal-utils sudo apt-get install librdf0-dev `

## Arguments

- files:

  Paths of files to upload to Zenodo.

- token:

  Zenodo [Personal access
  token](https://zenodo.org/account/settings/applications/tokens/new/).

- title:

  Metadata field: title of Zenodo repo.

- zipfile:

  Name of the zipped file containing all `files`. This allows users to
  preview the folder hierarchy on the Zenodo website.

- meta:

  Additional Zenodo repo metadata.

- sandbox:

  Whether to use the Zenodo or Zenodo Sandbox API.

- validate:

  Whether to validate if each files was published.

- verbose:

  Print messages.

## Examples

``` r
 
files <- sapply(seq_len(3), function(i){
    tmp <- tempfile(fileext = ".txt")
    writeLines(letters, tmp)
    return(tmp)
})
if (FALSE) { # \dontrun{
zout <- zenodo_upload(files=files,
                      title="test_repo")
} # }
```
