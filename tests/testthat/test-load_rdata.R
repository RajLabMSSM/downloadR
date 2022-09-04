test_that("load_rdata works", {
    
    fileName <- paste0("https://github.com/RajLabMSSM/",
    "Fine_Mapping_Shiny/raw/master/www/BST1.finemap_DT.RDS")
    dat <- load_rdata(fileName) 
    testthat::expect_gte(nrow(dat),900)
})
