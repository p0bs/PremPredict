
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
recent times. But how should we define ‘recent’? In order to duck this
question, you could choose a number of different time periods. Please
note that 0.0% and 100.0% outcomes in the results do not necessarily
signify certainty in their specific assessment, as:

- this model is typically used with more than 1,000 simulations; and
  more pertinently
- this model (like all models) is imperfect (but, I think, better than
  no model at all)

<br/>

## Example

Here is an example analysis, using data collected towards the end of the
2024/25 season.

First, we collect, combine and tidy the results data.

``` r
library(PremPredict)
data("example_thisSeason")

results_combined <- get_results(
  results_thisSeason = example_thisSeason, 
  seasons = 1L
  )

dim(results_combined)
#> [1] 652   9
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
#> Rows: 652
#> Columns: 8
#> $ matchday <date> 2023-08-12, 2023-08-12, 2023-08-12, 2023-08-12, 2023-08-13, …
#> $ homeTeam <chr> "ARS", "BOU", "EVE", "NEW", "BRE", "CHE", "MUN", "FUL", "LIV"…
#> $ awayTeam <chr> "NOT", "WHU", "FUL", "AST", "TOT", "LIV", "WOL", "BRE", "BOU"…
#> $ FTHG     <dbl> 2, 1, 0, 5, 2, 1, 1, 0, 3, 1, 2, 1, 4, 3, 0, 0, 0, 3, 2, 1, 1…
#> $ FTAG     <dbl> 1, 1, 1, 1, 2, 1, 0, 3, 1, 4, 0, 0, 0, 1, 1, 2, 1, 2, 2, 1, 3…
#> $ FTR      <chr> "H", "D", "A", "H", "D", "D", "H", "A", "H", "A", "H", "H", "…
#> $ played   <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, T…
#> $ match    <chr> "001", "002", "003", "004", "005", "006", "007", "008", "009"…
```

The number of rows isn’t 760, as some games from last year didn’t
feature all of our teams from this season (as three teams were promoted
from the Championship).

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
#>   2.49717    2.03650    0.82635    0.54145    1.10363    1.80490    0.58710  
#> sEVE_home  sFUL_home  sIPS_home  sLEI_home  sLIV_home  sMCI_home  sMUN_home  
#>   0.68189    0.96641   -2.10476   -1.10237    3.04903    2.35849    0.88298  
#> sNEW_home  sNOT_home  sSOU_home  sTOT_home  sWHU_home  sWOL_home  sARS_away  
#>   2.05827    0.95438   -2.70490    1.22332    0.54540    0.28027    2.13189  
#> sAST_away  sBOU_away  sBRE_away  sBRI_away  sCHE_away  sCPA_away  sEVE_away  
#>   0.90864    0.72265    0.47399    0.60825    0.96459    0.66492    0.35664  
#> sFUL_away  sIPS_away  sLEI_away  sLIV_away  sMCI_away  sMUN_away  sNEW_away  
#>   0.61757    0.02546   -1.16851    2.12468    1.97180    0.54222    0.74619  
#> sNOT_away  sSOU_away  sTOT_away  sWHU_away  sWOL_away       draw  
#>   0.56485   -1.89532    0.37914    0.51793    0.68725         NA  
#> 
#> Deviance:            1131.798 
#> Pearson chi-squared: 1206.453 
#> Residual df:         1160
```

\[I will add further details and more explanation in due course.\]

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
| Liverpool      |       89.23420 |
| Arsenal        |       76.58606 |
| Man City       |       69.37374 |
| Newcastle      |       67.28586 |
| Notts Forest   |       65.97324 |
| Aston Villa    |       64.78610 |
| Chelsea        |       64.55257 |
| Bournemouth    |       55.16355 |
| Fulham         |       55.09613 |
| Brighton       |       54.63824 |
| Brentford      |       53.55882 |
| Crystal Palace |       48.59985 |
| Wolves         |       44.38796 |
| Everton        |       44.31846 |
| Tottenham      |       44.23399 |
| Man Utd        |       44.20111 |
| West Ham       |       43.35263 |
| Ipswich        |       25.13070 |
| Leicester      |       22.37946 |
| Southampton    |       12.88449 |

On this basis, Liverpool look like strong favourites to win the season
(which they went on to do).

In order to project the likelihood of them becoming champions, however,
we need to simulate many possible outcomes.

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
|:---------------|---------:|---------:|---------:|--------:|---------:|-----------:|
| Liverpool      |  0.99947 |  1.00000 |  1.00000 | 1.00000 |  1.00000 |          0 |
| Arsenal        |  0.00053 |  0.99971 |  0.99998 | 1.00000 |  1.00000 |          0 |
| Man City       |  0.00000 |  0.84937 |  0.94411 | 0.98603 |  1.00000 |          0 |
| Newcastle      |  0.00000 |  0.52397 |  0.77407 | 0.92290 |  1.00000 |          0 |
| Notts Forest   |  0.00000 |  0.28892 |  0.55001 | 0.78434 |  1.00000 |          0 |
| Chelsea        |  0.00000 |  0.19916 |  0.40786 | 0.66660 |  1.00000 |          0 |
| Aston Villa    |  0.00000 |  0.13886 |  0.32376 | 0.63639 |  0.99998 |          0 |
| Bournemouth    |  0.00000 |  0.00001 |  0.00013 | 0.00171 |  0.86680 |          0 |
| Fulham         |  0.00000 |  0.00000 |  0.00003 | 0.00107 |  0.78650 |          0 |
| Brighton       |  0.00000 |  0.00000 |  0.00005 | 0.00076 |  0.70238 |          0 |
| Brentford      |  0.00000 |  0.00000 |  0.00000 | 0.00020 |  0.60255 |          0 |
| Crystal Palace |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.03467 |          0 |
| Tottenham      |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00310 |          0 |
| Wolves         |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00172 |          0 |
| Man Utd        |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00135 |          0 |
| Everton        |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00074 |          0 |
| West Ham       |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00021 |          0 |
| Ipswich        |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00000 |          1 |
| Leicester      |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00000 |          1 |
| Southampton    |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00000 |          1 |

Alternatively, this table can be generated, without calculating all
intermediate steps, by running the following code. (Note that the code
for `|> knitr::kable()` is purely for presentational purposes.)

``` r
run_simulations(
  results_thisSeason = example_thisSeason, 
  number_seasons = 1L, 
  lookback_rounds = 78L, 
  number_simulations = 100000, 
  value_seed = 2602L
  ) |> 
  knitr::kable()
```

| midName        | champion | top_four | top_five | top_six | top_half | relegation |
|:---------------|---------:|---------:|---------:|--------:|---------:|-----------:|
| Liverpool      |  0.99947 |  1.00000 |  1.00000 | 1.00000 |  1.00000 |          0 |
| Arsenal        |  0.00053 |  0.99971 |  0.99998 | 1.00000 |  1.00000 |          0 |
| Man City       |  0.00000 |  0.84937 |  0.94411 | 0.98603 |  1.00000 |          0 |
| Newcastle      |  0.00000 |  0.52397 |  0.77407 | 0.92290 |  1.00000 |          0 |
| Notts Forest   |  0.00000 |  0.28892 |  0.55001 | 0.78434 |  1.00000 |          0 |
| Chelsea        |  0.00000 |  0.19916 |  0.40786 | 0.66660 |  1.00000 |          0 |
| Aston Villa    |  0.00000 |  0.13886 |  0.32376 | 0.63639 |  0.99998 |          0 |
| Bournemouth    |  0.00000 |  0.00001 |  0.00013 | 0.00171 |  0.86680 |          0 |
| Fulham         |  0.00000 |  0.00000 |  0.00003 | 0.00107 |  0.78650 |          0 |
| Brighton       |  0.00000 |  0.00000 |  0.00005 | 0.00076 |  0.70238 |          0 |
| Brentford      |  0.00000 |  0.00000 |  0.00000 | 0.00020 |  0.60255 |          0 |
| Crystal Palace |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.03467 |          0 |
| Tottenham      |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00310 |          0 |
| Wolves         |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00172 |          0 |
| Man Utd        |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00135 |          0 |
| Everton        |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00074 |          0 |
| West Ham       |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00021 |          0 |
| Ipswich        |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00000 |          1 |
| Leicester      |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00000 |          1 |
| Southampton    |  0.00000 |  0.00000 |  0.00000 | 0.00000 |  0.00000 |          1 |
