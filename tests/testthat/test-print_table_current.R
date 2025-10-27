print_test <- print_table_current(data_table_latest)

test_that("dimensionally correct", {
  expect_equal(
    length(print_test),
    22L
  )
})
