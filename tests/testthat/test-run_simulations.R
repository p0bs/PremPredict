data_current_test <- PremPredict::example_thisSeason

data_test <- run_simulations(
  results_thisSeason = data_current_test,
  number_seasons = 1L,
  lookback_rounds = 78L,
  number_simulations = 25000,
  value_seed = 2602L
  )

test_that("dimensionally correct", {
  expect_equal(
    ncol(data_test),
    7L
  )
  expect_equal(
    nrow(data_test),
    20L
  )
})

test_that("calculation correct", {
  expect_equal(
    data_test |> dplyr::filter(midName == "Chelsea") |> dplyr::pull(top_four),
    0.1995,
    tolerance = 0.001
  )
})
