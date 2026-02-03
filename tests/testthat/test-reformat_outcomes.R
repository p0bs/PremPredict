test_that("functionality works", {
  expect_equal(
    reformat_outcomes(0.0002),
    "<0.1%"
  )

  expect_equal(
    reformat_outcomes(0.99997),
    ">99.9%"
  )

  expect_equal(
    reformat_outcomes(0.98),
    "98.0%"
  )

  expect_equal(
    reformat_outcomes(0.777777),
    "77.8%"
  )
})
