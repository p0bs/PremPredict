data_download <- get_openData(
  value_path = "https://raw.githubusercontent.com/openfootball/football.json/refs/heads/master/2024-25/en.1.json",
  table_teams = data("teams"),
  value_yearEnd = 2025L
  )

test_that("correct size", {
  expect_equal(nrow(data_download), 380)
  expect_equal(ncol(data_download), 10)
})
