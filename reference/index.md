# Package index

## Soup to nuts

Find the outcomes that result from a set of simulations, using the model
and relevant data

- [`run_simulations()`](run_simulations.md) : Assign the model
  parameters for unplayed games in this Premier League season.

## Data preparation

Preparing the data for modelling

- [`get_openData()`](get_openData.md) : Get the latest available results
  for the Premier League in a given season
- [`get_openData_schedule()`](get_openData_schedule.md) : Get the latest
  available schedule for the Premier League in a given season
- [`get_footballData()`](get_footballData.md) : Get the latest available
  results for the Premier League in a given season
- [`get_results()`](get_results.md) : Get the Premier League results for
  the desired seasons
- [`calc_game_latest()`](calc_game_latest.md) : Find the index of the
  latest game so far in this Premier League season
- [`get_results_filtered()`](get_results_filtered.md) : Get the Premier
  League results for the desired seasons
- [`calc_table_current()`](calc_table_current.md) : Calculate the
  current table for this Premier League season
- [`print_table_current()`](print_table_current.md) : Print the current
  table for this Premier League season

## Modelling

Modelling the data using Firth’s approach

- [`model_prepare_frame()`](model_prepare_frame.md) : Prepare the
  modelframe in order to run the prediction model
- [`model_run()`](model_run.md) : Run the prediction model
- [`model_extract_parameters()`](model_extract_parameters.md) : Run the
  prediction model
- [`model_parameters_unplayed()`](model_parameters_unplayed.md) : Assign
  the model parameters for unplayed games in this Premier League season.

## Prediction

Using the model to predict expected outcomes

- [`calc_points_expected_remaining()`](calc_points_expected_remaining.md)
  : Calculate the points expected to be gained by each team in the
  remainder of this Premier League season
- [`calc_points_expected_total()`](calc_points_expected_total.md) :
  Calculate the points expected to be gained by each team across this
  Premier League season

## Simulation

This is nothing to do with diving! In this section, we simulate many
games in order to understand the likelihood of given league outcomes
arising

- [`simulate_games()`](simulate_games.md) : Assign the model parameters
  for unplayed games in this Premier League season.
- [`simulate_standings()`](simulate_standings.md) : Simulate the
  standings over this Premier League season.
- [`simulate_outcomes()`](simulate_outcomes.md) : Show the likelihoods
  of all possible standings for all clubs over this Premier League
  season.

## Data

Data used in the package

- [`teams`](teams.md) : A dataset containing the teams in the latest
  Premier League season.
- [`previous_seasons`](previous_seasons.md) : A dataset containing the
  results of the Premier League from previous seasons.
- [`example_thisSeason`](example_thisSeason.md) : A dataset containing
  the results of the Premier League from this season so far (as
  committed on 2025-04-21).
- [`schedule_thisSeason`](schedule_thisSeason.md) : A dataset containing
  the schedule of the Premier League this.

## Internals

Functions used within the package but not exported

- [`calc_points_simulated_match()`](calc_points_simulated_match.md) :
  Calculate the result of one match, given model parameters and a
  uniform random variate.
- [`reformat_outcomes()`](reformat_outcomes.md) : Reformat the outcomes
  data for improved presentation.
