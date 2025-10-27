test_that("dimensionally correct", {
  expect_equal(
    nrow(data_modelframe),
    2280L
  )
  expect_equal(
    ncol(data_modelframe),
    4L
  )
  expect_equal(
    nrow(data_modelframe$s),
    2280L
  )
  expect_equal(
    ncol(data_modelframe$s),
    40L
  )
})
