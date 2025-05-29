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

data_test <- model_run(modelframe = data_modelframe)

test_that("class is correct", {
  expect_equal(
    class(data_test),
    c("gnm", "glm", "lm")
  )
})

test_that("calculates a deviance", {
  expect_equal(
    data_test$deviance,
    319.2,
    tolerance = 0.1
  )
})
