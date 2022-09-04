#' downloader wrapper
#'
#' R wrapper for \code{"axel"} (multi-threaded) and
#'  \code{"download.file"} (single-threaded) download functions.
#'
#' @return Local path to downloaded file.
#'
#' @param input_url URL to remote file.
#' @param output_dir The file directory you want to save the download in.
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
#' @param retry_method Method to automatically 
#' retry with when the selected \code{download_method} fails.
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
#' @export
#' @importFrom utils capture.output download.file
#' @importFrom methods is 
#' @examples
#' input_url <- paste(
#'     "https://github.com/RajLabMSSM/Fine_Mapping",
#'     "raw/master/Data/lead.SNP.coords.csv", sep="/")
#' out_path <- downloadR::downloader(input_url = input_url)
downloader <- function(input_url,
                       output_dir = tempdir(),
                       output_path = file.path(
                           output_dir,
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
                       retry_method = "download.file",
                       background = FALSE,
                       force_overwrite = FALSE,
                       quiet = TRUE,
                       show_progress = TRUE,
                       continue = TRUE, 
                       alternate = TRUE,
                       check_certificates = TRUE,
                       # conda_env=NULL,
                       timeout = 5*60,
                       conda_env = "echoR",
                       nThread = 1,
                       verbose=TRUE) {
    
    # echoverseTemplate:::source_all();
    # echoverseTemplate:::args2vars(downloadR::downloader)
    
    #### Check if it already exists ####
    if(file.exists(output_path) && 
       isFALSE(force_overwrite)){
        messager("Preexisting file detected.",
                 "Set force_overwrite=TRUE to override this.",v=verbose)
        return(output_path)
    }
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
            output_path <- axel(
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
            download_method <- validate_file(output_path = output_path, 
                                             download_method = download_method,
                                             retry_method = retry_method,
                                             verbose = verbose)
            #### Exit early ####
            if(is.null(download_method)) {
                report_time(start = start, v=verbose) 
                return(output_path)
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
        wget_path <- check_avail(tool = "wget",
                                 conda_env = conda_env,
                                 verbose = verbose)
        if (!is.null(wget_path)) {
            output_path <- wget(
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
            download_method <- validate_file(output_path = output_path,   
                                             download_method = download_method,
                                             retry_method = retry_method,
                                             verbose = verbose)
            #### Exit early ####
            if(is.null(download_method)) {
                report_time(start = start, v=verbose) 
                return(output_path)
            }
        } else {
            messager("wget not available.\n",
                     "Defaulting to download.file.", v=verbose)
            download_method <- "download.file"
        }    
    } 
    #### download.file ####
    ## Both used as an option and a backup method
    if (download_method %in% df_methods) {
        output_path <- download_file(input_url = input_url, 
                                     output_path = output_path, 
                                     timeout = timeout,
                                     quiet = quiet, 
                                     method = download_method,
                                     verbose = verbose)
        download_method <- validate_file(output_path = output_path,   
                                         download_method = download_method,
                                         error = TRUE,
                                         retry_method = NULL,
                                         verbose = verbose)
    }
    #### Report time ####
    report_time(start = start, v=verbose) 
    return(output_path)
}
