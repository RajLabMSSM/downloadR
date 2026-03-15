test_that("check_paths passes when lengths match", {
    ## Single element
    expect_no_error(
        downloadR:::check_paths(
            input_url = "http://example.com/a.csv",
            output_path = "/tmp/a.csv"
        )
    )
    ## Multiple elements
    expect_no_error(
        downloadR:::check_paths(
            input_url = c("http://example.com/a.csv",
                          "http://example.com/b.csv"),
            output_path = c("/tmp/a.csv", "/tmp/b.csv")
        )
    )
})

test_that("check_paths errors when lengths differ", {
    expect_error(
        downloadR:::check_paths(
            input_url = c("http://example.com/a.csv",
                          "http://example.com/b.csv"),
            output_path = "/tmp/a.csv"
        ),
        "same length"
    )
    expect_error(
        downloadR:::check_paths(
            input_url = "http://example.com/a.csv",
            output_path = c("/tmp/a.csv", "/tmp/b.csv")
        ),
        "same length"
    )
})

test_that("check_paths works with empty vectors", {
    ## Zero-length vectors have equal length
    expect_no_error(
        downloadR:::check_paths(
            input_url = character(0),
            output_path = character(0)
        )
    )
})
