test_that("dimensionally correct", {
  expect_equal(
    nrow(data_table_latest),
    20L
  )
  expect_equal(
    ncol(data_table_latest),
    4L
  )
})
