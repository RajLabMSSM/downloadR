download_file <- function(input_url,
                          output_path,
                          method = c("download.file",
                                     "auto",
                                     "internal",
                                     "wininet",
                                     "libcurl", 
                                     "wget",
                                     "curl"),
                          timeout=30 * 60,
                          quiet=FALSE,
                          verbose=TRUE){
    
    method <- method[1]
    if(method=="download.file") method <- "auto"
    messager("Downloading with download.file.",v=verbose)
    options(timeout = timeout)
    ### Set up paths ####
    dir.create(dirname(output_path), showWarnings = FALSE, recursive = TRUE) 
    utils::download.file(url = input_url, 
                         destfile = output_path,
                         quiet = quiet, 
                         method =  method)
    #### Download ####
    # catch_fail <- tryCatch(expr = {
    #     utils::download.file(url = input_url, 
    #                          destfile = out_file)
    # },
    # error = function(e) e, warning = function(w) w
    # )
    # msg <- paste0(
    #     "Failed to download from:\n", input_url,
    #     "\nThis is likely caused by inputting an ID which ",
    #     "couldn't be found. Check this and the URL."
    # )
    # if (methods::is(catch_fail, "error") |
    #     methods::is(catch_fail, "warning")) {
    #     stop(msg)
    # }
    return(output_path)
}