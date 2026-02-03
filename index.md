# PremPredict

The `PremPredict` package helps you to generate sensible predictions for
individual games or an entire season of the Premier League.

You can find my automatically-updated Premier League predictor (that
uses this codebase) on [the landing page of its
repo](https://github.com/p0bs/PL-scan?tab=readme-ov-file#predicting-this-seasons-premier-league).

  

## Installation

You can install the development version of PremPredict from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("p0bs/PremPredict")
```

  

## Approach

I use a simplified version of [David Firth’s
approach](https://github.com/DavidFirth/alt3code) and data from the
[Open Football repo](https://github.com/openfootball/football.json) on
GitHub to predict the outcome of this season’s Premier League.

The predictions are based on a team’s strength, given its performance in
recent times. But how should we define ‘recent’? In order to duck this
question, you could choose a number of different time periods. Please
also see some further disclaimers that are in these notes for my
automatically-updated Premier League predictor (as linked above).

  

## Example

Here is an example analysis, using data collected towards the end of the
2025/26 season.

First, we collect, combine and tidy the results data.

``` r
library(PremPredict)
data("example_thisSeason")

results_combined <- get_results(
  results_thisSeason = example_thisSeason, 
  seasons = 1L
  )

dim(results_combined)
#> [1] 760   9
```

Note that we want to look back across this season (so far) and its
predecessor.

``` r
game_latest <- calc_game_latest(results = results_combined)

results_filtered <- get_results_filtered(
  results = results_combined, 
  index_game_latest = game_latest, 
  lookback_rounds = 76L
  )

dplyr::glimpse(results_filtered)
#> Rows: 760
#> Columns: 8
#> $ matchday <date> 2024-08-16, 2024-08-17, 2024-08-17, 2024-08-17, 2024-08-17, …
#> $ homeTeam <chr> "MUN", "IPS", "ARS", "EVE", "NEW", "NOT", "WHU", "BRE", "CHE"…
#> $ awayTeam <chr> "FUL", "LIV", "WOL", "BRI", "SOU", "BOU", "AST", "CPA", "MCI"…
#> $ FTHG     <dbl> 1, 0, 2, 0, 1, 1, 1, 2, 0, 1, 2, 0, 2, 4, 0, 4, 0, 1, 2, 2, 1…
#> $ FTAG     <dbl> 0, 2, 0, 3, 0, 1, 2, 1, 2, 1, 1, 2, 1, 1, 1, 0, 2, 1, 6, 0, 1…
#> $ FTR      <chr> "H", "A", "H", "A", "H", "D", "A", "H", "A", "D", "H", "A", "…
#> $ played   <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, T…
#> $ match    <chr> "001", "002", "003", "004", "005", "006", "007", "008", "009"…
```

For reference, we can see the prevailing table.

``` r
data_table_current <- example_thisSeason |> 
  calc_table_current()

data_table_current |> 
  print_table_current()
```

| Team | Played |  GD | Points |
|:-----|-------:|----:|-------:|
| ARS  |      8 |  12 |     19 |
| MCI  |      8 |  11 |     16 |
| LIV  |      8 |   3 |     15 |
| BOU  |      8 |   3 |     15 |
| TOT  |      8 |   7 |     14 |
| CHE  |      8 |   7 |     14 |
| SUN  |      8 |   3 |     14 |
| CPA  |      8 |   4 |     13 |
| MUN  |      8 |  -1 |     13 |
| BRI  |      8 |   1 |     12 |
| AST  |      8 |   0 |     12 |
| EVE  |      8 |   0 |     11 |
| BRE  |      8 |  -1 |     10 |
| NEW  |      8 |   0 |      9 |
| FUL  |      8 |  -4 |      8 |
| LEE  |      8 |  -6 |      8 |
| BUR  |      8 |  -6 |      7 |
| NOT  |      8 | -10 |      5 |
| WHU  |      8 | -12 |      4 |
| WOL  |      8 | -11 |      2 |

We can now model the strengths of the sides at home and away.

``` r
data_model <- results_filtered |> 
  model_prepare_frame() |>
  model_run()

data_model
#> 
#> Call:
#> gnm::gnm(formula = count ~ -1 + s + draw, eliminate = match, 
#>     family = stats::quasipoisson, data = modelframe, start = rep(0, 
#>         2 * nTeams + 1))
#> 
#> Coefficients of interest:
#> sARS_home  sAST_home  sBOU_home  sBRE_home  sBRI_home  sBUR_home  sCHE_home  
#>    3.5887     3.3910     2.6672     2.7102     2.8616     3.0648     3.6256  
#> sCPA_home  sEVE_home  sFUL_home  sLEE_home  sLIV_home  sMCI_home  sMUN_home  
#>    2.1443     2.2261     2.2417     1.9925     4.2522     3.6907     2.2057  
#> sNEW_home  sNOT_home  sSUN_home  sTOT_home  sWHU_home  sWOL_home  sARS_away  
#>    3.3055     2.3953     4.3863     1.3325     1.0388     1.2459     3.5010  
#> sAST_away  sBOU_away  sBRE_away  sBRI_away  sBUR_away  sCHE_away  sCPA_away  
#>    2.2927     2.4675     2.0120     2.4678   -27.1656     2.5494     2.7080  
#> sEVE_away  sFUL_away  sLEE_away  sLIV_away  sMCI_away  sMUN_away  sNEW_away  
#>    1.9873     2.2584     1.1555     3.4702     2.7270     1.5472     2.3185  
#> sNOT_away  sSUN_away  sTOT_away  sWHU_away  sWOL_away       draw  
#>    2.7723     1.7477     1.9700     2.1102     1.5372     0.5316  
#> 
#> Deviance:            849.1585 
#> Pearson chi-squared: 904.8874 
#> Residual df:         879
```

Next, we use these team strengths to model future games across the
season.

``` r
data_parameters_unplayed <- data_model |> 
  model_extract_parameters()

data_model_parameters_unplayed <- model_parameters_unplayed(
  results = results_filtered,
  model_parameters = data_parameters_unplayed
  )

data_points_expected_remaining <- data_model_parameters_unplayed |>  
  calc_points_expected_remaining()

calc_points_expected_total(
  table_current = data_table_current,
  points_expected = data_points_expected_remaining
  ) |> 
  knitr::kable()
```

| midName        | Exp_Points_Ave |
|:---------------|---------------:|
| Liverpool      |       81.65226 |
| Arsenal        |       81.16959 |
| Man City       |       69.97195 |
| Chelsea        |       66.99225 |
| Sunderland     |       65.06298 |
| Aston Villa    |       60.51185 |
| Newcastle      |       59.42471 |
| Bournemouth    |       58.81905 |
| Brighton       |       58.03840 |
| Crystal Palace |       55.85868 |
| Brentford      |       50.92066 |
| Notts Forest   |       50.42615 |
| Everton        |       48.28917 |
| Fulham         |       47.81465 |
| Man Utd        |       46.34688 |
| Tottenham      |       40.73357 |
| Leeds Utd      |       36.83454 |
| Burnley        |       34.98184 |
| West Ham       |       33.80618 |
| Wolves         |       27.85355 |

On this basis, we can see who looks like favourites to win the season.

In order to project the likelihood of these favourites becoming
champions, though, we need to simulate many possible outcomes.

``` r
number_simulations <- 100000

data_simulate_games <- simulate_games(
  data_model_parameters_unplayed = data_model_parameters_unplayed,
  value_number_sims = number_simulations,
  value_seed = 2602L
  )

data_simulate_standings <- simulate_standings(
  data_game_simulations = data_simulate_games,
  data_table_latest = data_table_current
  )

simulate_outcomes(
  data_standings_simulations = data_simulate_standings,
  value_number_sims = number_simulations
  ) |> 
  knitr::kable()
```

| midName        | champion | top_four | top_five | top_six | top_half | relegation |
|:---------------|:---------|:---------|:---------|:--------|:---------|:-----------|
| Arsenal        | 46.9%    | 97.8%    | 99.1%    | 99.6%   | \>99.9%  | \<0.1%     |
| Liverpool      | 46.5%    | 98.3%    | 99.3%    | 99.7%   | \>99.9%  | \<0.1%     |
| Man City       | 4.1%     | 68.0%    | 80.4%    | 88.2%   | 99.0%    | \<0.1%     |
| Chelsea        | 1.5%     | 49.4%    | 66.4%    | 78.5%   | 97.7%    | \<0.1%     |
| Sunderland     | 0.5%     | 33.8%    | 53.3%    | 69.1%   | 97.0%    | \<0.1%     |
| Aston Villa    | 0.2%     | 14.5%    | 25.9%    | 39.1%   | 84.7%    | \<0.1%     |
| Bournemouth    | 0.2%     | 11.2%    | 20.6%    | 32.2%   | 78.5%    | \<0.1%     |
| Brighton       | \<0.1%   | 8.2%     | 16.3%    | 26.9%   | 75.1%    | \<0.1%     |
| Newcastle      | \<0.1%   | 10.8%    | 20.4%    | 32.2%   | 80.5%    | \<0.1%     |
| Crystal Palace | \<0.1%   | 5.5%     | 11.2%    | 19.2%   | 64.7%    | 0.3%       |
| Brentford      | \<0.1%   | 0.9%     | 2.3%     | 4.9%    | 33.6%    | 1.4%       |
| Notts Forest   | \<0.1%   | 0.8%     | 2.2%     | 4.5%    | 30.2%    | 2.3%       |
| Everton        | \<0.1%   | 0.4%     | 1.1%     | 2.5%    | 21.8%    | 3.1%       |
| Fulham         | \<0.1%   | 0.3%     | 0.9%     | 2.0%    | 18.8%    | 4.1%       |
| Man Utd        | \<0.1%   | 0.2%     | 0.5%     | 1.2%    | 14.1%    | 6.0%       |
| Tottenham      | \<0.1%   | \<0.1%   | \<0.1%   | 0.2%    | 3.6%     | 20.7%      |
| Leeds Utd      | \<0.1%   | \<0.1%   | \<0.1%   | \<0.1%  | 0.6%     | 44.5%      |
| West Ham       | \<0.1%   | \<0.1%   | \<0.1%   | \<0.1%  | 0.2%     | 67.3%      |
| Burnley        | \<0.1%   | \<0.1%   | \<0.1%   | \<0.1%  | \<0.1%   | 58.9%      |
| Wolves         | \<0.1%   | \<0.1%   | \<0.1%   | \<0.1%  | \<0.1%   | 91.2%      |

Alternatively, this table can be generated, without calculating all
intermediate steps, by running `run_simulations`.
