#' List Figshare files
#' 
#' List links to all downloadable files within a Figshare repository.
#' @param id Figshare repo ID.
#' @param suffix Filter results by file suffixes. 
#' Set to \code{NULL} to return all files (default).
#' @param as_datatable Return the return as 
#' a \link[data.table]{data.table} (default: \code{TRUE}),
#' instead of a nested list (\code{FALSE}).
#' @param verbose Print messages.
#' 
#' @export
#' @importFrom jsonlite fromJSON
#' @importFrom stats setNames
#' @importFrom data.table data.table
#' @examples 
#' files <- figshare_list(id="14703003", suffix=c(".RDS","cell_Info.txt"))
figshare_list <- function(id,
                          suffix=NULL,
                          as_datatable=TRUE,
                          verbose=TRUE){ 
  name <- NULL;
  
  messager("Searching for files in Figshare repo:",id,v=verbose)  
  files <- jsonlite::fromJSON(
    paste0("https://api.figshare.com/v2/articles/",id),
    simplifyDataFrame = TRUE)$files |>
    data.table::data.table()
  if(any(!is.null(id))){
    files <- files[grepl(paste(suffix,collapse = "|"),name, 
                         ignore.case = TRUE)]
  }
  messager(formatC(nrow(files)),"file(s) found.",v=verbose)
  if(isFALSE(as_datatable)){
    return(stats::setNames(files$download_url,
                           files$name))
  } else {
    return(files)
  } 
} 