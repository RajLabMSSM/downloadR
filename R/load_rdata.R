#' \code{load_rdata}
#'
#' Load processed data (\emph{.rda} format) using a function that assigns it
#' to a specific variable
#' (so you don't have to guess what the loaded variable name is).
#' If a \emph{.rda} file is remote and , it will first be downloaded using 
#' \link[downloadR]{downloader}.
#' @param fileName Name of the file to load.
#' @inheritDotParams downloader 
#' @returns R object
#' 
#' @export
#' @examples
#' fileName <- paste0("https://github.com/RajLabMSSM/",
#' "Fine_Mapping_Shiny/raw/master/www/BST1.finemap_DT.RDS")
#' dat <- load_rdata(fileName)
load_rdata <- function(fileName,
                       ...) { 
    
    if(grepl("\\.rds",fileName,ignore.case = TRUE)){
        if(!file.exists(fileName)){
            fileName <- url(fileName)
        }
        obj <- readRDS(fileName)
    } else if(grepl("\\.rda|\\.rdata",fileName,ignore.case = TRUE)){
        if(!file.exists(fileName)){
            fileName <- downloader(input_url = fileName,
                                   ...)
        } 
        load(fileName)
        obj <- get(ls()[ls() != "fileName"])
    } else {
        stp <- "File must be .rda/.rdata or .rds format."
        stop(stp)
    }
    return(obj)
}
