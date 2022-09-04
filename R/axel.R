#' axel downloader
#'
#' R wrapper for axel, which enables multi-threaded download
#'  of a single large file.
#'
#' @return Path where the file has been downloaded
#'
#' @inheritParams downloader
#' @family downloaders
#' @seealso \url{https://github.com/axel-download-accelerator/axel/}
#' @keywords internal
axel <- function(input_url,
                 output_path,
                 axel_path="axel",
                 background = FALSE, 
                 force_overwrite = FALSE,
                 quiet = TRUE,
                 alternate = TRUE,
                 # conda_env=NULL,
                 check_certificates = FALSE,
                 conda_env = "echoR",
                 nThread = 1,
                 verbose = TRUE) { 
    
    dir.create(dirname(output_path), showWarnings = FALSE, recursive = TRUE) 
    messager("Downloading with axel",paste0("[",nThread,"thread(s)]:"),
             input_url,"==>",output_path,
             v=verbose) 
    if (force_overwrite) {
        messager("+ Overwriting pre-existing file.",v=verbose)
        suppressWarnings(file.remove(output_path))
    } 
    #### Run axel ####
    cmd <- paste(
        axel_path,
        input_url,
        "-n", nThread,
        ## Checking certificates can sometimes cause issues
        if (check_certificates) "" else "--insecure",
        if (force_overwrite) "" else "--no-clobber",
        "-o", output_path,
        if (quiet) "-q" else "",
        # ifelse(alternate,"-a",""),
        if (background) "& bg" else ""
    ) 
    system(cmd)
    messager("\naxel download complete.",v=verbose)
    return(output_path)
}
