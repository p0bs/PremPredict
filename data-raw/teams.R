# Code to prepare `teams` dataset
# Ensure that `teamName` is consistent with those on the openfootball repo
#  and that all other names are unique

teams <- tibble::tribble(
  ~teamName, ~shortName, ~midName, ~openName,
  "Arsenal FC", "ARS", "Arsenal", "Arsenal FC",
  "Aston Villa FC", "AST", "Aston Villa", "Aston Villa",
  "AFC Bournemouth", "BOU", "Bournemouth", "AFC Bournemouth",
  "Brentford FC", "BRE", "Brentford", "Brentford FC",
  "Brighton & Hove Albion FC", "BRI", "Brighton", "Brighton & Hove Albion",
  "Burnley FC", "BUR", "Burnley", "Burnley FC",
  "Chelsea FC", "CHE", "Chelsea", "Chelsea FC",
  "Crystal Palace FC", "CPA", "Crystal Palace", "Crystal Palace",
  "Everton FC", "EVE", "Everton", "Everton FC",
  "Fulham FC", "FUL", "Fulham", "Fulham FC",
  "Leeds United", "LEE", "Leeds Utd", "Leeds United",
  "Liverpool FC", "LIV", "Liverpool", "Liverpool FC",
  "Manchester City FC", "MCI", "Man City", "Manchester City",
  "Manchester United FC", "MUN", "Man Utd", "Manchester United",
  "Newcastle United FC", "NEW", "Newcastle", "Newcastle United",
  "Nottingham Forest FC", "NOT", "Notts Forest", "Nottingham Forest",
  "Sunderland AFC", "SUN", "Sunderland", "Sunderland AFC",
  "Tottenham Hotspur FC", "TOT", "Tottenham", "Tottenham Hotspur",
  "West Ham United FC", "WHU", "West Ham", "West Ham United",
  "Wolverhampton Wanderers FC", "WOL", "Wolves", "Wolverhampton Wanderers"
  )

usethis::use_data(teams, overwrite = TRUE, internal = TRUE)
