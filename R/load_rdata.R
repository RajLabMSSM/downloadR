#' \code{load_rdata}
#'
#' Load processed data (\emph{.rda} format) using a function that assigns it
#' to a specific variable
#' (so you don't have to guess what the loaded variable name is).
#'
#' @param fileName Name of the file to load.
#'
#' @return R object
#' 
#' @examples
#' rda_url <- file.path("https://github.com/RajLabMSSM/echolocatoR",
#'                      "raw/master/data/BST1.rda")
#' out_path <- downloadR::downloader(input_url = rda_url,
#'                                   download_method = "axel")
#' BST1 <- downloadR::load_rdata(out_path)
#' @export
load_rdata <- function(fileName) {
    load(fileName)
    get(ls()[ls() != "fileName"])
}
