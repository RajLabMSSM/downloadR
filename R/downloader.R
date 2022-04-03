#' downloader wrapper
#'
#' R wrapper for \code{"axel"} (multi-threaded) and
#'  \code{"download.file"} (single-threaded) download functions.
#'
#' @return Local path to downloaded file.
#'
#' @param input_url URL to remote file.
#' @param output_path The file name you want to save the download as.
#' @param download_method 
#' \itemize{
#' \item{\code{"axel"} : }{Multi-threaded}
#' \item{\code{"wget"} : }{Single-threaded}
#' \item{\code{"download.file"} : }{Single-threaded}
#' \item{\code{"internal"} : }{Single-threaded 
#' (passed to \link[utils]{download.file})}
#' \item{\code{"wininet"} : }{Single-threaded 
#' (passed to \link[utils]{download.file})}
#' \item{\code{"libcurl"} : }{Single-threaded 
#' (passed to \link[utils]{download.file})}
#' \item{\code{"curl"} : }{Single-threaded 
#' (passed to \link[utils]{download.file})}
#' }
#'  or
#' \code{"download.file"} (single-threaded) .
#' @param background Run in background
#' @param force_overwrite Overwrite existing file.
#' @param quiet Run quietly.
#' @param show_progress show_progress.
#' @param continue continue.
#' @param nThread Number of threads to parallelize over.
#' @param alternate alternate,
#' @param check_certificates check_certificates
#' @param timeout How many seconds before giving up on download.
#' Passed to \code{download.file}. Default: \code{30*60} (30min).
#' @param conda_env Conda environment to use.
#' @param verbose Print messages.
#' @family downloaders
#'
#' @examples
#' rda_url<-"https://github.com/RajLabMSSM/echolocatoR/raw/master/data/BST1.rda"
#' out_path <- downloadR::downloader(
#'     input_url = rda_url,
#'     download_method = "axel"
#' )
#' @export
#' @importFrom utils capture.output download.file
#' @importFrom methods is
#' @importFrom parallel detectCores
downloader <- function(input_url,
                       output_path = file.path(
                           tempdir(),
                           basename(input_url)
                       ),
                       download_method = c("axel",
                                           "wget",
                                           "download.file", 
                                           "internal",
                                           "wininet",
                                           "libcurl", 
                                           "wget",
                                           "curl"
                                           ),
                       background = FALSE,
                       force_overwrite = FALSE,
                       quiet = TRUE,
                       show_progress = TRUE,
                       continue = TRUE,
                       nThread = parallel::detectCores() - 1,
                       alternate = TRUE,
                       check_certificates = TRUE,
                       # conda_env=NULL,
                       timeout = 30 * 60,
                       conda_env = "echoR",
                       verbose=TRUE) {
    
    #### Check method ####
    download_method <- tolower(download_method[1])
    df_methods <- c("download.file", 
                    "auto",
                    "internal",
                    "wininet",
                    "libcurl",
                    "curl")
    if(!download_method %in% c("axel","wget",df_methods)){
        msg <- paste0("download_method=",download_method," not recognized.\n",
                      "Must be one of:\n",
                      paste0(" - ",c("axel","wget","download.file"), collapse = "\n"))
        messager(msg,v=verbose)
        messager("Defaulting to download.file.",v=verbose)
        download_method <- "download.file"
    } 
    
    start <- Sys.time()
    #### axel ####
    if (download_method == "axel") {
        axel_avail <- is_installed(tool = "axel")
        axel_conda <- ""
        if(!axel_avail){
            #### Install axel (and other tools) via conda ####
            if(conda_env=="echoR"){
                conda_env2 <- echoconda::yaml_to_env()
            } 
            axel_conda <- echoconda::find_packages(
                packages = "axel",
                conda_env = conda_env,
                verbose = FALSE
            )
        } 
        if (axel_avail | (axel_conda != "axel")) {
            out_file <- axel(
                input_url = input_url,
                output_path = output_path,
                background = background,
                nThread = nThread,
                force_overwrite = force_overwrite,
                quiet = quiet, # output is hella long otherwise...
                alternate = alternate,
                conda_env = conda_env,
                check_certificates = check_certificates
            )
            if (!file.exists(out_file)) {
                message("axel download failed. Trying with download.file.")
                download_method <- "download.file"
            }
        } else {
            message(
                "axel not installed.\n",
                "For Mac users, please install via brew in the command ",
                "line (`brew install axel`)"
            )
            message("Defaulting to download.file")
            download_method <- "download.file"
        }
        
    #### wget ####
    } else if (download_method == "wget") {
        wget_avail <- is_installed(tool = "wget")
        wget_conda <- ""
        if(!wget_avail){
            #### Install axel (and other tools) via conda ####
            if(conda_env=="echoR"){
                conda_env2 <- echoconda::env_from_yaml()
            } 
            wget_conda <- echoconda::find_packages(
                packages = "wget",
                conda_env = conda_env,
                verbose = FALSE
            )
        } 
        if (wget_avail | (wget_conda != "wget")) {
            out_file <- wget(
                input_url = input_url,
                output_path = output_path,
                background = background,
                force_overwrite = force_overwrite,
                quiet = quiet,
                show_progress = show_progress,
                continue = continue,
                check_certificates = check_certificates,
                conda_env = conda_env
            )
        } else {
            message("wget not available.\n",
                     "Defaulting to download.file.")
            download_method <- "download.file"
        } 
    } 
     
    #### download.file #### 
    if (download_method %in% df_methods) {
        out_file <- download_file(input_url = input_url, 
                                  output_path = output_path, 
                                  timeout = timeout,
                                  quiet =  quiet)
    }
    #### Report time ####
    report_time(start = start, v=verbose) 
    return(out_file)
}
