test_that("dimensionally correct", {
  expect_equal(
    ncol(data_points_expected_remaining),
    3L
  )
  expect_equal(
    nrow(data_points_expected_remaining),
    20L
  )
})

test_that("calculation correct", {
  expect_equal(
    data_points_expected_remaining |> dplyr::filter(team == "LIV") |> dplyr::slice(1) |> dplyr::pull(value),
    66.7,
    tolerance = 0.01
  )
})
