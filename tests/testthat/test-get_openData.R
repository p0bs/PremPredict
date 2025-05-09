data_download <- get_openData(
  value_path = system.file(
    "extdata",
    "en1_2324.json",
    package = "PremPredict",
    mustWork = TRUE
    ),
  table_teams = data("teams"),
  value_yearEnd = 2025L
  )

test_that("correct size", {
  # Without promotion/relegation: 380; with: 272
  expect_equal(nrow(data_download), 272)
  expect_equal(ncol(data_download), 10)
})
