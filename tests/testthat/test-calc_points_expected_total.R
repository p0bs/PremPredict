test_that("dimensionally correct", {
  expect_equal(
    ncol(data_calc_points_expected_total),
    2L
  )
  expect_equal(
    nrow(data_calc_points_expected_total),
    20L
  )
})

test_that("calculation correct", {
  expect_equal(
    data_calc_points_expected_total |> dplyr::filter(midName == "Liverpool") |> dplyr::slice(1) |> dplyr::pull(Exp_Points_Ave),
    81.7,
    tolerance = 0.01
  )
})
