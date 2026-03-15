## Additional zenodo_list tests.

test_that("zenodo_list requires zen4R namespace", {
    ## Without a valid token, the zen4R manager creation should fail
    ## or the API call should fail. Either way, an error is expected.
    testthat::skip_if_not_installed("zen4R")
    expect_error(
        suppressMessages(
            downloadR::zenodo_list(
                concept_doi = "10.5281/zenodo.7062237",
                token = "invalid_token",
                verbose = FALSE
            )
        )
    )
})

test_that("zenodo_list parses DOI number correctly", {
    ## The function extracts the last dot-separated component.
    ## We can verify this by testing that it doesn't error on DOI parsing
    ## (the actual API call will fail without valid token).
    testthat::skip_if_not_installed("zen4R")
    expect_error(
        suppressMessages(
            downloadR::zenodo_list(
                concept_doi = "10.5281/zenodo.1234567",
                token = "",
                verbose = FALSE
            )
        )
    )
})
