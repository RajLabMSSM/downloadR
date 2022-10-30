#' wget
#'
#' R wrapper for wget
#' 
#' @return Local path to downloaded file.
#' 
#' @family downloaders
#' @keywords internal
wget <- function(input_url,
                 output_path,
                 wget_path="wget",
                 background = TRUE,
                 force_overwrite = FALSE,
                 quiet = FALSE,
                 show_progress = TRUE,
                 continue = TRUE,
                 check_certificates = FALSE,
                 conda_env = "echoR_mini",
                 verbose = TRUE) {
    # https://stackoverflow.com/questions/21365251/how-to-run-wget-in-background-for-an-unattended-download-of-files
    ## -bqc makes wget run in the background quietly
    dir.create(dirname(output_path), showWarnings = FALSE, recursive = TRUE) 
    messager("Downloading with wget",paste0("[",1," thread]:"),"\n",
             input_url,"==>",output_path, v=verbose) 
    cmd <- paste(
        wget_path,
        input_url,
        "-np",
        ## Checking certificates can sometimes cause issues
        if (check_certificates) "" else "--no-check-certificate",
        if (background) "-b" else "",
        if (continue) "-c" else "",
        if (quiet) "-q" else "",
        if (show_progress) "--show-progress" else "",
        "-O", output_path,
        if (force_overwrite) "" else "--no-clobber"
    ) 
    system(cmd) 
    return(output_path)
}
