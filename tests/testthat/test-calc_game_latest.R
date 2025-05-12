data_current_test <- structure(
  list(
    number_match = c("001", "002", "003", "004", "005", "006", "007", "008", "009", "010"),
    number_match_integer = 1:10,
    matchday = structure(
      c(19951, 19952, 19952, 19952, 19952, 19952, 19952, 19953, 19953, 19954),
      class = "Date"
      ),
    homeTeam = c("MUN", "IPS", "ARS", "EVE", "NEW", "NOT", "WHU", "BRE", "CHE", "LEI"),
    awayTeam = c("FUL", "LIV", "WOL", "BRI", "SOU", "BOU", "AST", "CPA", "MCI", "TOT"),
    FTHG = c(1L, 0L, 2L, 0L, 1L, 1L, 1L, 2L, 0L, 1L),
    FTAG = c(0L, 2L, 0L, 3L, 0L, 1L, 2L, 1L, 2L, 1L),
    FTR = structure(
      c(3L, 1L, 3L, 1L, 3L, 2L, 1L, 3L, 1L, 2L),
      levels = c("A", "D", "H"),
      class = "factor"
      ),
    played = c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE),
    year_end = c(2025L, 2025L, 2025L, 2025L, 2025L, 2025L, 2025L, 2025L, 2025L, 2025L)
    ),
  row.names = c(NA, -10L),
  class = c("tbl_df", "tbl", "data.frame")
  )

data_results <- get_results(
  results_thisSeason = data_current_test,
  seasons = 0L
  )

test_that("functionality works for example", {
  expect_equal(
    calc_game_latest(data_results),
    282L
    )
})
