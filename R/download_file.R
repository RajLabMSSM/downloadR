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
                          quiet=FALSE){
    
    method <- method[1]
    if(method=="download.file") method <- "auto"
    message("Downloading with download.file.")
    options(timeout = timeout)
    ### Set up paths ####
    dir.create(output_path, showWarnings = FALSE, recursive = TRUE)
    out_file <- file.path(output_path, basename(input_url))
    utils::download.file(url = input_url, 
                         destfile = out_file,
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
    return(out_file)
}