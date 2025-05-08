# Code to prepare `teams` dataset

teams <- tibble::tribble(
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

usethis::use_data(teams, overwrite = TRUE)
