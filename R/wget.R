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
                 background = TRUE,
                 force_overwrite = FALSE,
                 quiet = FALSE,
                 show_progress = TRUE,
                 continue = TRUE,
                 check_certificates = FALSE,
                 conda_env = "echoR") {
    # https://stackoverflow.com/questions/21365251/how-to-run-wget-in-background-for-an-unattended-download-of-files
    ## -bqc makes wget run in the background quietly
    dir.create(output_path, showWarnings = FALSE, recursive = TRUE)
    out_file <- file.path(output_path, basename(input_url))
    wget <- echoconda::find_package(
        package = "wget",
        conda_env = conda_env,
        verbose = quiet
    )
    cmd <- paste(
        wget,
        input_url,
        "-np",
        ## Checking certificates can sometimes cause issues
        if (check_certificates) "" else "--no-check-certificate",
        if (background) "-b" else "",
        if (continue) "-c" else "",
        if (quiet) "-q" else "",
        if (show_progress) "--show-progress" else "",
        "-P", output_path,
        if (force_overwrite) "" else "--no-clobber"
    )
    # print(cmd)
    system(paste(cmd, "&& echo '+ wget download complete.'"))
    return(out_file)
}
