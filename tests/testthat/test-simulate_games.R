test_that("dimensionally correct", {
  expect_equal(
    ncol(data_simulate_games),
    7L
  )
  expect_equal(
    nrow(data_simulate_games),
    3000000L
  )
})

test_that("calculation correct", {
  expect_equal(
    data_simulate_games |> dplyr::filter(match == "601") |> dplyr::summarise(ave = mean(points_home)) |> dplyr::pull(ave),
    0.9363,
    tolerance = 0.001
  )
})
