# Code to prepare `teams` dataset
# Ensure that `teamName` is consistent with those on the openfootball repo
#  and that all other names are unique

teams <- tibble::tribble(
  ~teamName, ~shortName, ~midName, ~openName,
  "Arsenal", "ARS", "Arsenal", "Arsenal FC",
  "Aston Villa", "AST", "Aston Villa", "Aston Villa",
  "Bournemouth", "BOU", "Bournemouth", "AFC Bournemouth",
  "Brentford", "BRE", "Brentford", "Brentford FC",
  "Brighton", "BRI", "Brighton", "Brighton & Hove Albion",
  "Burnley", "BUR", "Burnley", "Burnley FC",
  "Chelsea", "CHE", "Chelsea", "Chelsea FC",
  "Crystal Palace", "CPA", "Crystal Palace", "Crystal Palace",
  "Everton", "EVE", "Everton", "Everton FC",
  "Fulham", "FUL", "Fulham", "Fulham FC",
  "Leeds", "LEE", "Leeds Utd", "Leeds United",
  "Liverpool", "LIV", "Liverpool", "Liverpool FC",
  "Man City", "MCI", "Man City", "Manchester City",
  "Man United", "MUN", "Man Utd", "Manchester United",
  "Newcastle", "NEW", "Newcastle", "Newcastle United",
  "Nott'm Forest", "NOT", "Notts Forest", "Nottingham Forest",
  "Sunderland", "SUN", "Sunderland", "Sunderland AFC",
  "Tottenham", "TOT", "Tottenham", "Tottenham Hotspur",
  "West Ham", "WHU", "West Ham", "West Ham United",
  "Wolves", "WOL", "Wolves", "Wolverhampton Wanderers"
  )

usethis::use_data(teams, overwrite = TRUE, internal = TRUE)
