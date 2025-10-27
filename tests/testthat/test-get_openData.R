teams_2425 <- tibble::tribble(
  ~teamName, ~shortName, ~midName,
  "Arsenal FC", "ARS", "Arsenal",
  "Aston Villa FC", "AST", "Aston Villa",
  "AFC Bournemouth", "BOU", "Bournemouth",
  "Brentford FC", "BRE", "Brentford",
  "Brighton & Hove Albion FC", "BRI", "Brighton",
  "Chelsea FC", "CHE", "Chelsea",
  "Crystal Palace FC", "CPA", "Crystal Palace",
  "Everton FC", "EVE", "Everton",
  "Fulham FC", "FUL", "Fulham",
  "Ipswich Town FC", "IPS", "Ipswich",
  "Leicester City FC", "LEI", "Leicester",
  "Liverpool FC", "LIV", "Liverpool",
  "Manchester City FC", "MCI", "Man City",
  "Manchester United FC", "MUN", "Man Utd",
  "Newcastle United FC", "NEW", "Newcastle",
  "Nottingham Forest FC", "NOT", "Notts Forest",
  "Southampton FC", "SOU", "Southampton",
  "Tottenham Hotspur FC", "TOT", "Tottenham",
  "West Ham United FC", "WHU", "West Ham",
  "Wolverhampton Wanderers FC", "WOL", "Wolves"
)

data_download <- get_openData(
  value_path = system.file(
    "extdata",
    "en1_2324.json",
    package = "PremPredict",
    mustWork = TRUE
    ),
  table_teams = teams_2425,
  value_yearEnd = 2025L
  )

test_that("correct size", {
  # Without promotion/relegation: 380; with: 272
  expect_equal(nrow(data_download), 272)
  expect_equal(ncol(data_download), 10)
})
