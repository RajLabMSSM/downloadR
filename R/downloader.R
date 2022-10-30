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
#' @returns Named vector of files, where the names are the URLs and the values 
#' are the paths to the respective local files.
#' @family downloaders
#'
#' @export
#' @importFrom utils capture.output download.file
#' @importFrom methods is 
#' @importFrom stats setNames
#' @examples
#' input_url <- paste(
#'     "https://github.com/RajLabMSSM/Fine_Mapping",
#'     "raw/master/Data/lead.SNP.coords.csv", sep="/")
#' output_paths <- downloadR::downloader(input_url = input_url)
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
                       timeout = 5*60,
                       conda_env = "echoR_mini",
                       nThread = 1,
                       verbose=TRUE) {
    
    # echoverseTemplate:::source_all();
    # echoverseTemplate:::args2vars(downloadR::downloader)
    
    #### Check args ####
    check_paths(input_url = input_url, 
                output_path = output_path)
    #### Iterate across files ####
    output_paths <- lapply(stats::setNames(seq_len(length(input_url)),
                                           input_url), 
                           function(i){
        downloader_one(input_url = input_url[[i]],
                       output_dir = output_dir,
                       output_path = output_path[[i]],
                       download_method = download_method,
                       retry_method = retry_method,
                       background = background,
                       force_overwrite = force_overwrite,
                       quiet = quiet,
                       show_progress = show_progress,
                       continue = continue, 
                       alternate = alternate,
                       check_certificates = check_certificates, 
                       timeout = timeout,
                       conda_env = conda_env,
                       nThread = nThread,
                       verbose = verbose)
    }) |> unlist()
    return(output_paths)
}
