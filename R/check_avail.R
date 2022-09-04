#' Check tool availability
#' 
#' Check whether a tool is installed and usable from the command line 
#' by simply invoking its name. If not, will try to find an executable of 
#' the tool via the specified \code{conda_env}.
#' Finally, if no executable can be found, will simply return \code{NULL}.
#' 
#' @param tool Tool name, or full path to tool executable.
#' @inheritParams echoconda::find_packages
#' 
#' @keywords internal
#' @importFrom echoconda yaml_to_env find_packages
check_avail <- function(tool,
                        conda_env = "echoR",
                        verbose = TRUE){
    is_avail <- is_installed(tool = tool) 
    if(isTRUE(is_avail)){
        tool_path <- tool
    } else {
        #### (build and) use conda env ####
        conda_env <- echoconda::yaml_to_env(yaml_path = conda_env, 
                                            show_contents = FALSE,
                                            verbose = verbose)
        tool_path <- echoconda::find_packages(
            packages = tool,
            conda_env = conda_env,
            return_path = TRUE,
            verbose = verbose
        )[[1]][1]
        if(is.na(tool_path)){
            tool_path <- NULL
        }
    } 
    return(tool_path)
}
