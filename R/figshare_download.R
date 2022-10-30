#' Download Figshare files
#' 
#' Download files from a Figshare repository. 
#' @inheritParams figshare_list
#' @export 
#' @examples 
#' files <- figshare_download(id="14703003", suffix=c(".RDS","cell_Info.txt"))
figshare_download <- function(id,
                              suffix=NULL,
                              as_datatable=TRUE,
                              verbose=TRUE){ 
    files <- figshare_list(id = id, 
                           suffix = suffix, 
                           verbose = verbose)
    files_local <- downloader(input_url = files$download_url,
                              verbose = verbose)
    return(files_local)
} 