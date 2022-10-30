#' Zenodo upload
#' 
#' Search for files and then upload them to Zenodo. 
#' @source 
#' \code{
#' #### Installing zen4R ####
#' ## has some system deps that have to be installed beforehand.
#' sudo apt-get install raptor2-utils
#' sudo apt-get install rasqal-utils
#' sudo apt-get install librdf0-dev
#' }
#' @param files Paths of files to upload to Zenodo.
#' @param title Metadata field: title of Zenodo repo.
#' @param meta Additional Zenodo repo metadata.
#' @param zipfile Name of the zipped file containing all \code{files}.
#' This allows users to preview the folder hierarchy on the Zenodo website.
#' @param validate Whether to validate if each files was published.
#' @inheritParams zenodo_list
#' @inheritParams base::list.files
#' 
#' @export  
#' @importFrom utils zip
#' @examples  
#' files <- sapply(seq_len(3), function(i){
#'     tmp <- tempfile(fileext = ".txt")
#'     writeLines(letters, tmp)
#'     return(tmp)
#' })
#' \dontrun{
#' zout <- zenodo_upload(files=files,
#'                       title="test_repo")
#' }
zenodo_upload <- function(files,
                          token=Sys.getenv("zenodo_token"),
                          title,
                          zipfile=file.path(tempdir(),title),
                          meta=list(title=title,
                                    description="",
                                    uploadType="dataset",
                                    Creator=list(
                                        firstname="",
                                        lastname="",
                                        affiliation=""
                                    )),
                          sandbox=TRUE,
                          validate=TRUE,
                          verbose=TRUE){  
    
    requireNamespace("zen4R")
    force(title)   
    force(files)
    #### Compress ####
    if(!is.null(zipfile)){
        messager("ZENODO:: Compressing files into:",zipfile,v=verbose)
        out <- utils::zip(zipfile = zipfile,
                          files = files,
                          extras = list("-x *.gz"))
        zipped_file <- paste(zipfile,".zip")
    }  else {
        zipped_file <- NULL
    }
    #### Upload to zenodo ####
    zenodo <- zen4R::ZenodoManager$new(
        #### zenodo sandbox ####
        url = if(isTRUE(sandbox)) {
            "https://sandbox.zenodo.org/api"
        } else {
            "https://zenodo.org/api"
        },
        token = token, 
        ##  use "DEBUG" to see detailed API operation logs, 
        ## use NULL if you don't want logs at all
        logger = "INFO" 
    )   
    #### Create new record ####
    messager("ZENODO:: Creating a new record.",v=verbose)
    newrec <- zen4R::ZenodoRecord$new() 
    messager("ZENODO:: Adding metadata.",v=verbose)
    newrec$setTitle(title = meta$title)
    newrec$setDescription(description = meta$description)
    newrec$setUploadType(uploadType = meta$uploadType)
    newrec$addCreator(firstname = meta$Creator$firstname, 
                      lastname = meta$Creator$lastname, 
                      affiliation = meta$Creator$affiliation) 
    messager("ZENODO:: Depositing record.",v=verbose)
    newrec <- zenodo$depositRecord(newrec) 
    #### Upload files ####
    messager("ZENODO:: Uploading files.",v=verbose)
    
    #### Upload files ####
    uploads <- lapply(stats::setNames(files,
                                      files),
                      function(x){
          ### Go to sleep for 1h to reset limit of 5000 files/hour.
          if(which(files==x) %in% seq(4999,4999*100,5000)) {
              message("Waiting for 1 hour to reset upload limits.")
              Sys.sleep(3600)  
          }    
          ### Go to sleep for 1min to reset limit of 100 files/min.
          if(which(files==x) %in% seq(99,99*10000,100)) {
              message("Waiting for 60 seconds to reset upload limits.")
              Sys.sleep(60)  
          }   
          message("Uploading: ",x)
          zenodo$uploadFile(x, record = newrec) 
      })
    if(!is.null(zipped_file)){
        messager("Uploading: ",zipped_file,v=verbose)
        file_res <- zenodo$uploadFile(zipped_file, record = newrec)   
    }
    #### Publish record ####
    messager("ZENODO:: Publishing files.",v=verbose)
    rec_res <- zenodo$publishRecord(recordId = newrec$id) 
    
    #### Validate everything was published #### 
    # doi <- ??
    # myrec <- zenodo$getDepositionByConceptDOI(doi)
    # zen_files <- zenodo$getFiles(myrec$id)
    # # message(length(zen_files)," Zenodo files found.")  
    # zfiles <- sapply(zen_files, function(x){x$filename})
    # files <- all(
    #     c(basename(unlist(files)),zipped_file) %in% zfiles
    # )
    return(list(files=files,
                zipped_file=zipped_file))
}
