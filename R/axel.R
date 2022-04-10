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
                 nThread = 1,
                 force_overwrite = FALSE,
                 quiet = TRUE,
                 alternate = TRUE,
                 # conda_env=NULL,
                 check_certificates = FALSE,
                 conda_env = "echoR",
                 verbose = TRUE) { 
    dir.create(output_path, showWarnings = FALSE, recursive = TRUE)
    out_file <- file.path(output_path, basename(input_url))
    messager("Downloading with axel",paste0("[",nThread,"thread(s)]:"),"\n",
             input_url,"==>",out_file,
             v=verbose) 
    if (force_overwrite) {
        messager("+ Overwriting pre-existing file.",v=verbose)
        suppressWarnings(file.remove(out_file))
    } 
    #### Run axel ####
    cmd <- paste(
        axel_path,
        input_url,
        "-n", nThread,
        ## Checking certificates can sometimes cause issues
        if (check_certificates) "" else "--insecure",
        if (force_overwrite) "" else "--no-clobber",
        "-o", out_file,
        if (quiet) "-q" else "",
        # ifelse(alternate,"-a",""),
        if (background) "& bg" else ""
    ) 
    system(cmd)
    messager("\naxel download complete.",v=verbose)
    return(out_file)
}
