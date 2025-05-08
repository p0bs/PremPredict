data(teams)

test_that("correct size", {
  expect_equal(nrow(teams), 20)
  expect_equal(ncol(teams), 3)
})
