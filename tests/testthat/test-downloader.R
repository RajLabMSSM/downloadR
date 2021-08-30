test_that("downloader works", {
    
    rda_url <- "https://github.com/RajLabMSSM/echolocatoR/raw/master/data/BST1.rda"
    
    run_tests <- function(out_path){
        testthat::expect_true(file.exists(out_path))
    }
    
    #### axel ####
    out_path <- downloadR::downloader(input_url = rda_url,
                                      download_method = "axel")
    run_tests(out_path)
   
     #### wget ####
    out_path <- downloadR::downloader(input_url = rda_url,
                                      download_method = "wget")
    run_tests(out_path)
    
    #### download.file ####
    out_path <- downloadR::downloader(input_url = rda_url,
                                      download_method = "download.file")
    run_tests(out_path)
    
    ### download.file: libcurl ####
    out_path <- downloadR::downloader(input_url = rda_url,
                                      download_method = "libcurl")
    run_tests(out_path)
    
    ### download.file: curl ####
    out_path <- downloadR::downloader(input_url = rda_url,
                                      download_method = "curl")
    run_tests(out_path)
    
    #### default ####
    out_path <- downloadR::downloader(input_url = rda_url,
                                      download_method = "typo")
    run_tests(out_path) 
})
