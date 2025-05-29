
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PremPredict <a href="https://p0bs.github.io/PremPredict/"><img src="man/figures/logo.png" align="right" height="104" alt="PremPredict website" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/p0bs/PremPredict/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/p0bs/PremPredict/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/p0bs/PremPredict/graph/badge.svg)](https://app.codecov.io/gh/p0bs/PremPredict)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The `PremPredict` package helps you to generate sensible predictions for
individual games or an entire season of the Premier League.

You can find my automatically-updated Premier League predictor (that
uses this codebase) on [the landing page of its
repo](https://github.com/p0bs/PL-scan?tab=readme-ov-file#predicting-this-seasons-premier-league).

<br/>

## Installation

You can install the development version of PremPredict from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("p0bs/PremPredict")
```

<br/>

## Approach

I use a simplified version of [David Firth’s
approach](https://github.com/DavidFirth/alt3code) and data from the
[Open Football repo](https://github.com/openfootball/football.json) on
GitHub to predict the outcome of this season’s Premier League.

The predictions are based on a team’s strength, given its performance in
recent times. But how should we define *recent*? In order to duck this
question, you could choose a number of different time periods. Please
note that 0.0% and 100.0% outcomes in the results do not necessarily
signify certainty in their specific assessment, as:

- this model is typically used with more than 1,000 simulations; and
  more pertinently
- this model (like all models) is imperfect (but, I think, better than
  no model at all)

<br/>

## Example

Here is an example analysis, using data collected on 12th May 2025
(which wasn’t quite up to date by then).

First, we collect, combine and tidy the results data.

``` r
library(PremPredict)
data("example_thisSeason")

results_combined <- get_results(example_thisSeason, seasons = 1L)
dim(results_combined)
#> [1] 652   9
```

However, we only wish to look back a full year from the current point
(which is where each team has a small number of games remaining in the
season).

``` r
game_latest <- calc_game_latest(results = results_combined)

results_filtered <- get_results_filtered(
  results = results_combined, 
  index_game_latest = game_latest, 
  lookback_rounds = 38L
  )

dplyr::glimpse(results_filtered)
#> Rows: 433
#> Columns: 8
#> $ matchday <date> 2024-04-06, 2024-04-06, 2024-04-07, 2024-04-07, 2024-04-13, …
#> $ homeTeam <chr> "WOL", "BRI", "MUN", "TOT", "NEW", "NOT", "BOU", "LIV", "WHU"…
#> $ awayTeam <chr> "WHU", "ARS", "LIV", "NOT", "TOT", "WOL", "MUN", "CPA", "FUL"…
#> $ FTHG     <dbl> 1, 0, 2, 3, 4, 2, 2, 0, 0, 0, 6, 0, 2, 3, 5, 1, 5, 0, 2, 2, 0…
#> $ FTAG     <dbl> 2, 3, 2, 1, 0, 2, 2, 1, 2, 2, 0, 2, 0, 1, 2, 3, 0, 1, 0, 0, 4…
#> $ FTR      <chr> "A", "A", "D", "H", "H", "D", "D", "A", "A", "A", "H", "A", "…
#> $ played   <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, T…
#> $ match    <chr> "220", "221", "222", "223", "224", "225", "226", "227", "228"…
```

The number of rows isn’t 380, as some games this season have yet to be
played and some games from last year didn’t feature all of our teams
from this season (as three teams were promoted from the Championship).

For reference, we can see the prevailing table.

``` r
data_table_current <- example_thisSeason |> 
  calc_table_current()

data_table_current |> 
  print_table_current()
```

| Team | Played |  GD | Points |
|:-----|-------:|----:|-------:|
| LIV  |     32 |  43 |     76 |
| ARS  |     33 |  34 |     66 |
| NEW  |     33 |  18 |     59 |
| MCI  |     33 |  22 |     58 |
| CHE  |     33 |  18 |     57 |
| NOT  |     32 |  13 |     57 |
| AST  |     33 |   6 |     57 |
| BOU  |     33 |  12 |     49 |
| FUL  |     33 |   3 |     48 |
| BRI  |     33 |   0 |     48 |
| BRE  |     33 |   6 |     46 |
| CPA  |     33 |  -4 |     44 |
| EVE  |     33 |  -6 |     38 |
| MUN  |     33 |  -8 |     38 |
| WOL  |     33 | -13 |     38 |
| TOT  |     32 |  11 |     37 |
| WHU  |     33 | -18 |     36 |
| IPS  |     33 | -38 |     21 |
| LEI  |     32 | -45 |     18 |
| SOU  |     33 | -54 |     11 |

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
#> sARS_home  sAST_home  sBOU_home  sBRE_home  sBRI_home  sCHE_home  sCPA_home  
#>   2.11616    1.80472    0.83416    0.91304    0.54456    2.10914    0.91035  
#> sEVE_home  sFUL_home  sIPS_home  sLEI_home  sLIV_home  sMCI_home  sMUN_home  
#>   0.95829    0.62203   -2.27916   -1.22314    2.77280    2.07414    0.50124  
#> sNEW_home  sNOT_home  sSOU_home  sTOT_home  sWHU_home  sWOL_home  sARS_away  
#>   1.78552    1.27272   -2.91937    0.48145    0.01834   -0.42682    1.99077  
#> sAST_away  sBOU_away  sBRE_away  sBRI_away  sCHE_away  sCPA_away  sEVE_away  
#>   0.72014    0.68944    0.51242    0.70031    1.08462    1.07638   -0.09467  
#> sFUL_away  sIPS_away  sLEI_away  sLIV_away  sMCI_away  sMUN_away  sNEW_away  
#>   0.97085   -0.18998   -1.37943    1.87401    1.59837    0.10322    0.93390  
#> sNOT_away  sSOU_away  sTOT_away  sWHU_away  sWOL_away       draw  
#>   0.94902   -2.17842   -0.40044    0.21730    0.34709         NA  
#> 
#> Deviance:            698.4004 
#> Pearson chi-squared: 763.8907 
#> Residual df:         722
```

\[I will add further details and more explanation in due course.\]

Next, we use these team strengths to model future games across the
season.

``` r
data_parameters_unplayed <- data_model |> 
  model_extract_parameters()

data_points_expected_remaining <- model_parameters_unplayed(
  results = results_filtered,
  model_parameters = data_parameters_unplayed
  ) |> 
  calc_points_expected_remaining()

calc_points_expected_total(
  table_current = data_table_current,
  points_expected = data_points_expected_remaining
  )
#> # A tibble: 20 × 2
#>    midName        Exp_Points_Ave
#>    <chr>                   <dbl>
#>  1 Liverpool                88.7
#>  2 Arsenal                  75.9
#>  3 Man City                 69.1
#>  4 Newcastle                67.7
#>  5 Notts Forest             67.5
#>  6 Chelsea                  65.5
#>  7 Aston Villa              64.7
#>  8 Bournemouth              55.8
#>  9 Fulham                   55.5
#> 10 Brighton                 54.7
#> 11 Brentford                54.3
#> 12 Crystal Palace           50.1
#> 13 Everton                  44.4
#> 14 Man Utd                  43.1
#> 15 West Ham                 43.1
#> 16 Wolves                   43.1
#> 17 Tottenham                42.2
#> 18 Ipswich                  24.9
#> 19 Leicester                22.5
#> 20 Southampton              12.7
```

On this basis, Liverpool look like strong favourites to win the season
(which they actually did). However, to project the likelihood of them
doing so, we need to simulate many possible outcomes.

\[More to follow.\]
