is_installed <- function(tool){
    length(system(paste("which",tool),
                  intern = TRUE)) != 0
}