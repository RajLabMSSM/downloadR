test_that("zenodo_upload works", {
  
    files <- sapply(seq_len(3), function(i){
        tmp <- tempfile(fileext = ".txt")
        writeLines(letters, tmp)
        return(tmp)
    })
    testthat::expect_error(
        zout <- zenodo_upload(files=files,
                              title="test_repo")
    )
})
