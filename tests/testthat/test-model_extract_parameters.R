test_that("dimensionally correct", {
  expect_equal(
    nrow(data_parameters_unplayed),
    40L
  )
  expect_equal(
    ncol(data_parameters_unplayed),
    3L
  )
})

test_that("parameter extraction correct", {
  expect_equal(
    data_parameters_unplayed |> dplyr::slice(1) |> dplyr::pull(estimate_e),
    36.2,
    tolerance = 0.01
  )
})
