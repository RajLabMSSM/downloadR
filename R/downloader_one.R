downloader_one <- function(input_url,
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
                           conda_env = "echoR_mini",
                           nThread = 1,
                           verbose=TRUE){
    
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
