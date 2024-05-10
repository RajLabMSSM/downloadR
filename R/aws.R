#' AWS downloader
#'
#' AWS S3 bucket downloader.
#'
#' @returns Path where the file has been downloaded
#'
#' @inheritParams downloader
#' @inheritParams aws.s3::save_object
#' @inheritDotParams aws.s3::save_object
#' @family downloaders
#' @seealso \url{https://blog.djnavarro.net/posts/2022-03-17_using-aws-s3-in-r/}
#' @export
#' @importFrom aws.s3 save_object
#' @examples
#' bucket <- "s3://broad-alkesgroup-ukbb-ld/"
#' input_url <- "UKBB_LD/chr10_135000001_138000001.gz"
#' out <- aws(input_url = input_url, bucket = bucket)
aws <- function(input_url,
                output_path=file.path(tempdir(),basename(input_url)),
                bucket,
                force_overwrite = FALSE, 
                verbose = TRUE,
                ...) { 
    
    dir.create(dirname(output_path), showWarnings = FALSE, recursive = TRUE) 
    messager("Downloading with aws.s3:",
             input_url,"==>",output_path,
             v=verbose) 
    if (force_overwrite) {
        messager("+ Overwriting pre-existing file.",v=verbose)
        suppressWarnings(file.remove(output_path))
    } 
    #### Run AWS ####
   #  future::plan("multisession")  
   #  object ="UKBB_LD/chr4_14000001_17000001"  
   # s3fs::s3_dir_ls("s3://broad-alkesgroup-ukbb-ld/") 
    output_path <- aws.s3::save_object(
        object = input_url,
        bucket = bucket, 
        file = output_path,
        show_progress = verbose,
        ...
    )
    return(output_path)
}
