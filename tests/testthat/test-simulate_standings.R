data_current_test <- PremPredict::example_thisSeason

data_results_zero <- get_results(
  results_thisSeason = data_current_test,
  seasons = 0L
)

value_latest_game <- calc_game_latest(results = data_results_zero)

data_table_latest <- calc_table_current(results = data_results_zero)

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

data_simulate_games <- simulate_games(
  data_model_parameters_unplayed = data_model_parameters_unplayed,
  value_number_sims = 1000L,
  value_seed = 2602L
  )

data_test <- simulate_standings(
  data_game_simulations = data_simulate_games,
  data_table_latest = data_table_latest
  )

test_that("dimensionally correct", {
  expect_equal(
    ncol(data_test),
    3L
  )
  expect_equal(
    nrow(data_test),
    20000L
  )
})

test_that("calculation correct", {
  expect_equal(
    data_test |> dplyr::filter(sim == 1, midName == "Notts Forest") |> dplyr::pull(ranking),
    4L
  )
})
