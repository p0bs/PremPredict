#' @title Reformat the outcomes data for improved presentation.
#'
#' @description This function takes the likelihoods of all possible standings for all clubs over this Premier League season and reformats them for improved presentation..
#' @param value This is the outcome value to be reformatted.
#' @keywords Sport
#' @examples
#' \dontrun{
#' reformat_outcomes(
#'   value = 0.94
#'   )
#' }

reformat_outcomes <- function(value) {
  dplyr::case_when(
    dplyr::between(value, 0.001, 0.999) ~ paste0(
      as.character(
        format(
          round(100 * value, digits = 1),
          nsmall = 1
        )
      ),
      "%"
    ),
    value < 0.001 ~ "<0.1%",
    value > 0.999 ~ ">99.9%",
    .default = "Error"
  )
}
