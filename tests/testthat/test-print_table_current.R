data_current_test <- PremPredict::example_thisSeason

data_results_zero <- get_results(
  results_thisSeason = data_current_test,
  seasons = 0L
)

data_test <- calc_table_current(results = data_results_zero)

print_test <- print_table_current(data_test)

test_that("dimensionally correct", {
  expect_equal(
    length(print_test),
    22L
  )
})
