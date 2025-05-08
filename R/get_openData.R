#' @title Get the latest available results for the Premier League in a given season
#'
#' @description This function retrieves the latest data on the Premier League results for a given season.
#' @param value_path This  is the location of the data on GitHub. See the example below for reference and use an address of the form, 'https://raw.githubusercontent.com/openfootball/football.json/refs/heads/master/2024-25/en.1.json'.
#' @param table_teams These are the teams in the season's Premier League, available as the `teams` dataset in this package.
#' @param value_yearEnd This is the integer required as year in which the season ends.
#' @source <https://github.com/openfootball/football.json>
#' @keywords Sport
#' @export
#' @examples
#' \dontrun{
#' get_openData(
#'   value_path = "https://raw.githubusercontent.com/openfootball/football.json/refs/etc",
#'   table_teams = teams,
#'   value_yearEnd = 2025L
#'   )
#' }
#'
#' @importFrom rlang .data

get_openData <- function(value_path, table_teams, value_yearEnd){

  table_teams <- PremPredict::teams

  temp <- jsonlite::read_json(
    path = value_path,
    simplifyVector = TRUE
  )$matches

  temp1 <- jsonlite::flatten(temp) |>
    dplyr::mutate(
      matchweek = as.integer(stringr::str_sub(.data$round, 10, -1)),
      matchday = lubridate::as_date(.data$date)
    ) |>
    dplyr::select(.data$matchweek, .data$matchday, .data$team1, .data$team2, .data$score.ft) |>
    tidyr::unnest_wider(col = .data$score.ft, names_sep = ".", simplify = TRUE) |>
    dplyr::select(.data$matchweek, .data$matchday, .data$team1, .data$team2, "FTHG" = .data$score.ft.1, "FTAG" = .data$score.ft.2)

  temp2 <- dplyr::left_join(x = temp1, y = table_teams, by = c("team1" = "teamName")) |>
    dplyr::rename("homeTeam" = .data$shortName)

  temp3 <- dplyr::left_join(x = temp2, y = table_teams, by = c("team2" = "teamName")) |>
    dplyr::filter(
      !is.na(.data$homeTeam),
      !is.na(.data$shortName)
    ) |>
    dplyr::mutate(
      number_match = sprintf("%03d", dplyr::row_number()),
      number_match_integer = dplyr::row_number(),
      FTR = dplyr::case_when(
        .data$FTHG > .data$FTAG ~ "H",
        .data$FTHG == .data$FTAG ~ "D",
        .data$FTHG < .data$FTAG ~ "A",
        .default = NA_character_
      ),
      FTR = factor(.data$FTR, levels = c("A", "D", "H")),
      unplayed = is.na(.data$FTHG) & is.na(.data$FTAG),
      played = !.data$unplayed,
      year_end = value_yearEnd
    ) |>
    dplyr::select(.data$number_match, .data$number_match_integer, .data$matchday, .data$homeTeam, "awayTeam" = .data$shortName, .data$FTHG, .data$FTAG, .data$FTR, .data$played, .data$year_end)

  return(temp3)
}
