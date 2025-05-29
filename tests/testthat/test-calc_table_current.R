data_current_test <- PremPredict::example_thisSeason

data_results_zero <- get_results(
  results_thisSeason = data_current_test,
  seasons = 0L
  )

data_test <- calc_table_current(results = data_results_zero)

test_that("dimensionally correct", {
  expect_equal(
    nrow(data_test),
    20L
  )
  expect_equal(
    ncol(data_test),
    4L
  )
})
