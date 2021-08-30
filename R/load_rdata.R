#' \code{load_rdata}
#'
#' Load processed data (\emph{.rda} format) using a function that assigns it
#' to a specific variable
#' (so you don't have to guess what the loaded variable name is).
#'
#' @param fileName Name of the file to load.
#'
#' @return R object
#' @export
load_rdata <- function(fileName) {
    load(fileName)
    get(ls()[ls() != "fileName"])
}
