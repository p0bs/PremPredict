data_current_test <- PremPredict::example_thisSeason

data_results_zero <- get_results(
  results_thisSeason = data_current_test,
  seasons = 0L
)

value_latest_game <- calc_game_latest(results = data_results_zero)

data_results_filtered <- get_results_filtered(
  results = data_results_zero,
  index_game_latest = value_latest_game,
  lookback_rounds = 19L
)

data_modelframe <- model_prepare_frame(results = data_results_filtered)

data_model <- model_run(modelframe = data_modelframe)

data_parameters <- model_extract_parameters(model_output = data_model)

data_test <- model_parameters_unplayed(
  results = data_results_filtered,
  model_parameters = data_parameters
)

test_that("dimensionally correct", {
  expect_equal(
    ncol(data_test),
    11L
  )
})
