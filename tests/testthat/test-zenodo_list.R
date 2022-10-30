test_that("zenodo_list works", {
  
    ## Need to add a token
    testthat::expect_error(
        zen_dat <- zenodo_list(concept_doi="10.5281/zenodo.7062237")
    )
})
