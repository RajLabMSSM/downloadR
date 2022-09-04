test_that("downloader works", {
    
    input_url <- paste(
        "https://github.com/RajLabMSSM/Fine_Mapping",
        "raw/master/Data/lead.SNP.coords.csv", sep="/")
    
    run_tests <- function(out_path){
        testthat::expect_true(file.exists(out_path))
        file.remove(out_path)
    }
    
    #### axel ####
    out_path <- downloadR::downloader(input_url = input_url,
                                      download_method = "axel")
    run_tests(out_path)
   
    #### wget ####
    out_path <- downloadR::downloader(input_url = input_url,
                                      download_method = "wget")
    run_tests(out_path)
    
    #### download.file ####
    out_path <- downloadR::downloader(input_url = input_url,
                                      download_method = "download.file")
    run_tests(out_path)
    
    ### download.file: libcurl ####
    out_path <- downloadR::downloader(input_url = input_url,
                                      download_method = "libcurl")
    run_tests(out_path)
    
    ### download.file: curl ####
    ## Fails randomly on some machines, like my local Macbook 
    ## (yet passes on GHA's MacOS?)
    # out_path <- downloadR::downloader(input_url = input_url,
    #                                   download_method = "curl")
    # run_tests(out_path)
    
    #### default ####
    out_path <- downloadR::downloader(input_url = input_url,
                                      download_method = "typo")
    run_tests(out_path) 
})
