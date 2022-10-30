test_that("figshare_list works", {
  
    files <- figshare_list(id="14703003", suffix=c(".RDS","cell_Info.txt"))
    testthat::expect_true(methods::is(files,"data.table"))
    testthat::expect_equal(dim(files), c(10,7))
})
