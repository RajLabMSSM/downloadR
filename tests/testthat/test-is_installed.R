test_that("is_installed returns TRUE for known system tools", {
    ## bash should always be available on unix-like systems
    res <- downloadR:::is_installed("bash")
    expect_true(res)
})

test_that("is_installed returns FALSE for nonexistent tools", {
    res <- downloadR:::is_installed("nonexistent_tool_xyz_abc_123")
    expect_false(res)
})

test_that("is_installed returns logical", {
    res <- downloadR:::is_installed("ls")
    expect_type(res, "logical")
    expect_length(res, 1)
})
