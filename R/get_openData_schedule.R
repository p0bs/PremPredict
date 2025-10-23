#' @title Get the latest available schedule for the Premier League in a given season
#'
#' @description This function retrieves the latest data on the Premier League results for a given season.
#' @param value_path This  is the location of the data on GitHub. See the example below for reference and use an address of the form, 'https://raw.githubusercontent.com/openfootball/football.json/refs/heads/master/2024-25/en.1.json'. Note that this data is updated with scores later in the season.
#' @param table_teams These are the teams in the season's Premier League, available as the `teams` dataset in this package.
#' @param value_yearEnd This is the integer required as the year in which the season ends.
#' @source <https://github.com/openfootball/football.json>
#' @keywords Sport
#' @export
#' @examples
#' \dontrun{
#' get_openData_schedule(
#'   value_path = "https://raw.githubusercontent.com/openfootball/football.json/refs/etc",
#'   table_teams = teams,
#'   value_yearEnd = 2025L
#'   )
#' }
#'
#' @importFrom rlang .data

get_openData_schedule <- function(value_path, table_teams, value_yearEnd){

  jsonlite::read_json(
    path = value_path,
    simplifyVector = TRUE
    )$matches |>
    dplyr::mutate(
      matchweek = as.integer(stringr::str_sub(.data$round, 10, -1)),
      matchday = lubridate::as_date(.data$date)
    ) |>
    dplyr::left_join(table_teams, by = c("team1" = "openName")) |>
    dplyr::rename("homeTeam" = "shortName") |>
    dplyr::select("matchweek", "matchday", "homeTeam", "team2") |>
    dplyr::left_join(table_teams, by = c("team2" = "openName")) |>
    dplyr::select("matchweek", "matchday", "homeTeam", "awayTeam" = "shortName") |>
    dplyr::filter(
      !is.na(.data$homeTeam),
      !is.na(.data$awayTeam)
    ) |>
    dplyr::mutate(
      number_match = sprintf("%03d", dplyr::row_number()),
      number_match_integer = dplyr::row_number(),
      year_end = value_yearEnd
    ) |>
    dplyr::select("number_match", "number_match_integer", "matchday", "homeTeam", "awayTeam", "year_end")
}
