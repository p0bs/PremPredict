test_that("class is correct", {
  expect_equal(
    class(data_model),
    c("gnm", "glm", "lm")
  )
})

test_that("calculates a deviance", {
  expect_equal(
    data_model$deviance,
    849.2,
    tolerance = 0.1
  )
})
