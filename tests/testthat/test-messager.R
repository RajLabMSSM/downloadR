test_that("messager prints message when v=TRUE", {
    expect_message(
        downloadR:::messager("hello", "world", v = TRUE),
        "hello world"
    )
})

test_that("messager suppresses when v=FALSE", {
    expect_no_message(
        downloadR:::messager("hello", v = FALSE)
    )
})

test_that("messager concatenates multiple arguments", {
    expect_message(
        downloadR:::messager("a", "b", "c", v = TRUE),
        "a b c"
    )
})
