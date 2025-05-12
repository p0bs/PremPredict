#' @title Run the prediction model
#'
#' @description This function takes the relevant filtered results from the Premier League and uses them to model each team's capabilities, both at home and away.
#' @param modelframe This is the modelframe generated in `model_prepare_frame`.
#' @keywords Sport
#' @export
#' @examples
#' \dontrun{
#' model_run(
#'   modelframe = data_modelframe
#'   )
#' }
#'

model_run <- function(modelframe){

  teams <- PremPredict::teams
  nTeams <- nrow(teams)

  gnm::gnm(
    count ~ -1 + s + draw,
    eliminate = match,
    family = stats::quasipoisson,
    data = modelframe,
    start = rep(0, 2 * nTeams + 1)
  )

  }
