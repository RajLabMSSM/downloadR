validate_file <- function(output_path,
                          download_method,
                          min_size = 1,
                          retry_method = "download.file",
                          error = FALSE,
                          verbose = TRUE){
    
    if(!file.exists(output_path)) { 
        stp <- paste(download_method,"download failed. No file retrieved.")
        if(isTRUE(error)) stop(stp) else messager(stp,v=verbose)
        if(!is.null(retry_method)) {
            messager("Retrying with download_method:",retry_method)
            return(retry_method)
        }
    } else if(file.size(output_path) < min_size){
        stp <- paste(download_method,"download failed. Removing empty file.")
        if(isTRUE(error)) stop(stp) else messager(stp,v=verbose)
        out <- file.remove(output_path) 
        if(!is.null(retry_method)) {
            messager("Retrying with download_method:",retry_method)
            return(retry_method)
        }
    } else {
        messager(download_method,"download successful.",v=verbose)
        return(NULL)
    }
}
