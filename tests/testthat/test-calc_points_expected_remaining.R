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

data_parameters_unplayed <- model_extract_parameters(model_output = data_model)

data_model_parameters_unplayed <- model_parameters_unplayed(
  results = data_results_filtered,
  model_parameters = data_parameters_unplayed
)

data_test <- calc_points_expected_remaining(games_remaining = data_model_parameters_unplayed)

test_that("dimensionally correct", {
  expect_equal(
    ncol(data_test),
    3L
  )
  expect_equal(
    nrow(data_test),
    20L
  )
})

test_that("calculation correct", {
  expect_equal(
    data_test |> dplyr::filter(team == "LIV") |> dplyr::slice(1) |> dplyr::pull(value),
    13.76,
    tolerance = 0.01
  )
})
