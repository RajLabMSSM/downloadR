test_that("load_rdata works", {
    
    rda_url <- "https://github.com/RajLabMSSM/echolocatoR/raw/master/data/BST1.rda"
    out_path <- downloadR::downloader(input_url = rda_url)
    
    BST1_dat <- downloadR::load_rdata(out_path)
    testthat::expect_equal(nrow(BST1_dat),6216)
})
