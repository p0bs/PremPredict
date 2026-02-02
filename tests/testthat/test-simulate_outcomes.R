test_that("dimensionally correct", {
  expect_equal(
    ncol(data_simulate_outcomes),
    7L
  )
  expect_equal(
    nrow(data_simulate_outcomes),
    20L
  )
})

# test_that("each calculation sums to one", {
#   expect_equal(
#     as.vector(colSums(data_simulate_outcomes[, -1])),
#     c(1, 4, 5, 6, 10, 3),
#     tolerance = 0.001
#   )
# })
