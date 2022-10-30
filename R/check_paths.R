check_paths <- function(input_url,
                        output_path){
    if(length(input_url)!=length(output_path)){
        stp <- "input_url must have the same length as output_path"
        stop(stp)
    }
}
