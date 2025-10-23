#' @title Get the latest available results for the Premier League in a given season
#'
#' @description This function retrieves the latest data on the Premier League results for a given season.
#' @param value_link This is the link for the data on the web. For example, you could use 'https://www.football-data.co.uk/mmz4281/2526/E0.csv'.
#' @param table_schedule This is the location of the schedule data, as generated through an in-built dataset or by using `get_openData_schedule`.
#' @param table_teams These are the teams in the season's Premier League, available as the `teams` dataset in this package.
#' @param value_yearEnd This is the integer required as the year in which the season ends.
#' @source <https://www.football-data.co.uk>
#' @keywords Sport
#' @export
#' @examples
#' \dontrun{
#' get_footballData(
#'   value_link = "https://www.football-data.co.uk/mmz4281/2526/E0.csv",
#'   table_schedule = schedule_thisSeason,
#'   table_teams = teams,
#'   value_yearEnd = 2026L
#'   )
#' }
#'
#' @importFrom rlang .data

get_footballData <- function(value_link, table_schedule, table_teams, value_yearEnd){

  data_results <- readr::read_csv(
    file = value_link) |>
    dplyr::select("HomeTeam", "AwayTeam", "FTHG", "FTAG", "FTR") |>
    dplyr::left_join(table_teams, by = c("HomeTeam" = "teamName")) |>
    dplyr::rename("homeTeam" = "shortName") |>
    dplyr::left_join(table_teams, by = c("AwayTeam" = "teamName")) |>
    dplyr::rename("awayTeam" = "shortName") |>
    dplyr::mutate(
      FTR = factor(.data$FTR, levels = c("A", "D", "H")),
      year_end = value_yearEnd
    ) |>
    dplyr::select("homeTeam", "awayTeam", "FTHG", "FTAG", "FTR", "year_end")

  table_schedule |>
    dplyr::left_join(
      data_results,
      by = c("homeTeam" = "homeTeam", "awayTeam" = "awayTeam", "year_end" = "year_end")
      ) |>
    dplyr::mutate(
      unplayed = is.na(.data$FTHG) & is.na(.data$FTAG),
      played = !.data$unplayed
    ) |>
    dplyr::select("number_match", "number_match_integer", "matchday", "homeTeam", "awayTeam", "FTHG", "FTAG", "FTR", "played", "year_end")

}
