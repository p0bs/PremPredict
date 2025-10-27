data_current_test <- example_thisSeason

data_results_zero <- get_results(
  results_thisSeason = data_current_test,
  seasons = 0L
  )

data_results_one <- get_results(
  results_thisSeason = data_current_test,
  seasons = 1L
  )

test_that("zero seasons has correct number of rows", {
  expect_equal(
    nrow(data_results_zero),
    nrow(data_current_test)
    )
})

test_that("one season has more rows than zero seasons", {
  expect_gt(
    nrow(data_results_one),
    nrow(data_results_zero)
  )
})
