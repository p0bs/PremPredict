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

data_results_zero <- get_results(
  results_thisSeason = data_current_test,
  seasons = 0L
  )

value_latest_game <- calc_game_latest(results = data_results_zero)

data_results_filtered <- get_results_filtered(
  results = data_results_zero,
  index_game_latest = value_latest_game,
  lookback_rounds = 1L
  )

data_test <- calc_table_current(results = data_results_filtered)

test_that("dimensionally correct", {
  expect_equal(
    nrow(data_test),
    20L
  )
  expect_equal(
    ncol(data_test),
    4L
  )
})
