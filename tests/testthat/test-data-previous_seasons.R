data("previous_seasons")

test_that("correct size", {
  expect_equal(ncol(previous_seasons), 10)
})
