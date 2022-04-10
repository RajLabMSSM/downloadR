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
#' input_url <- paste(
#'     "https://github.com/RajLabMSSM/echolocatoR",
#'     "raw/master/data/BST1.rda", sep="/")
#'     
#' out_path <- downloadR::downloader(
#'     input_url = input_url)
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
    
    # echoverseTemplate:::source_all();
    # echoverseTemplate:::args2vars(downloadR::downloader)
    
    #### Check method ####
    df_methods <- eval(formals(download_file)$method)
    download_method <- downloader_check_method(
        download_method = download_method, 
        verbose = verbose
    ) 
    start <- Sys.time()
    #### Use axel ####
    if (download_method == "axel") {
        axel_path <- check_avail(tool = "axel",
                                 conda_env = conda_env,
                                 verbose = verbose)
        if (!is.null(axel_path)) {
            out_file <- axel(
                input_url = input_url,
                output_path = output_path,
                axel_path = axel_path,
                background = background,
                nThread = nThread,
                force_overwrite = force_overwrite,
                quiet = quiet, # output is hella long otherwise...
                alternate = alternate,
                conda_env = conda_env,
                check_certificates = check_certificates
            )
            if (!file.exists(out_file)) {
                messager("axel download failed. Trying with download.file.",
                         v=verbose)
                download_method <- "download.file"
            }
        } else {
            messager(
                "axel not installed.\n",
                "For Mac users, please install via brew in the command",
                "line (`brew install axel`)", v=verbose
            )
            message("Defaulting to download.file")
            download_method <- "download.file"
        }
        
    #### Use wget ####
    } else if (download_method == "wget") {
        wget_path <- check_avail(tool = "axel",
                                 conda_env = conda_env,
                                 verbose = verbose)
        if (!is.null(wget_path)) {
            out_file <- wget(
                input_url = input_url,
                output_path = output_path,
                wget_path = wget_path,
                background = background,
                force_overwrite = force_overwrite,
                quiet = quiet,
                show_progress = show_progress,
                continue = continue,
                check_certificates = check_certificates,
                conda_env = conda_env,
                verbose = verbose
            )
        } else {
            messager("wget not available.\n",
                     "Defaulting to download.file.", v=verbose)
            download_method <- "download.file"
        } 
        
    #### download.file ####  
    } else if (download_method %in% df_methods) {
        out_file <- download_file(input_url = input_url, 
                                  output_path = output_path, 
                                  timeout = timeout,
                                  quiet =  quiet, 
                                  method = download_method,
                                  verbose = verbose)
    } else {
        stop("No valid download_method could be identified.")
    } 
    #### Report time ####
    report_time(start = start, v=verbose) 
    return(out_file)
}
