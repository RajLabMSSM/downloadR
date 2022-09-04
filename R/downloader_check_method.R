downloader_check_method <- function(download_method,
                                    verbose=TRUE){
    
    download_method <- tolower(download_method[1]) 
    all_methods <- eval(formals(downloader)$download_method)
    if(!download_method %in% all_methods){ 
        messager("download_method=",download_method,"not recognized.",
                 "Must be one of:",
                 paste("\n -",all_methods,collapse = ""),
                 v=verbose)
        messager("Defaulting to download.file.",v=verbose)
        download_method <- "download.file"
    } 
    return(download_method)
}