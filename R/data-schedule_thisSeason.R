#' A dataset containing the schedule of the Premier League this.
#'
#' @format A data frame with many rows (one for each game this season) and 6 variables:
#' \describe{
#'   \item{number_match}{A character of the index for the game in question}
#'   \item{number_match_integer}{The integer version of `number_match`}
#'   \item{matchday}{The date on which the game occurred}
#'   \item{homeTeam}{The `shortName` of the team that played at home in the match}
#'   \item{awayTeam}{The `shortName` of the team that played away in the match}
#'   \item{year_end}{The calendar year in which the season ended}
#' }
#' @source \url{https://github.com/openfootball/football.json}
"schedule_thisSeason"
