# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)
library(PremPredict)

data_currentSeason <- example_thisSeason

data_results_zero <- get_results(
  results_thisSeason = data_currentSeason,
  seasons = 1L
)

value_latest_game <- calc_game_latest(results = data_results_zero)

data_results_filtered <- get_results_filtered(
  results = data_results_zero,
  index_game_latest = value_latest_game,
  lookback_rounds = 46L
)

data_table_latest <- calc_table_current(results = data_currentSeason)

data_modelframe <- model_prepare_frame(results = data_results_filtered)

data_model <- model_run(modelframe = data_modelframe)

data_parameters_unplayed <- model_extract_parameters(model_output = data_model)

data_model_parameters_unplayed <- model_parameters_unplayed(
  results = data_results_filtered,
  model_parameters = data_parameters_unplayed
)

data_points_expected_remaining <- calc_points_expected_remaining(
  games_remaining = data_model_parameters_unplayed
  )

data_calc_points_expected_total <- calc_points_expected_total(
  table_current = data_table_latest,
  points_expected = data_points_expected_remaining
)

data_simulate_games <- simulate_games(
  data_model_parameters_unplayed = data_model_parameters_unplayed,
  value_number_sims = 10000L,
  value_seed = 2602L
)

data_simulate_standings <- simulate_standings(
  data_game_simulations = data_simulate_games,
  data_table_latest = data_table_latest
)

data_simulate_outcomes <- simulate_outcomes(
  data_standings_simulations = data_simulate_standings,
  value_number_sims = 10000L
)

test_check("PremPredict")
