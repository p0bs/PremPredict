test_that("dimensionally correct", {
  expect_equal(
    ncol(data_simulate_standings),
    3L
  )
  expect_equal(
    nrow(data_simulate_standings),
    200000L
  )
})

test_that("calculation correct", {
  expect_equal(
    data_simulate_standings |> dplyr::filter(sim == 1, midName == "Notts Forest") |> dplyr::pull(ranking),
    13L
  )
})
