
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
(which is where each team has two games remaining in the season).

``` r
game_latest <- calc_game_latest(results = results_combined)

results_filtered <- get_results_filtered(
  results = results_combined, 
  index_game_latest = game_latest, 
  lookback_rounds = 38L
  )

dplyr::glimpse(results_filtered)
#> Rows: 412
#> Columns: 8
#> $ matchday <date> 2024-04-27, 2024-04-27, 2024-04-27, 2024-04-27, 2024-04-28, …
#> $ homeTeam <chr> "WHU", "FUL", "EVE", "AST", "BOU", "TOT", "NOT", "CHE", "ARS"…
#> $ awayTeam <chr> "LIV", "CPA", "BRE", "CHE", "BRI", "ARS", "MCI", "TOT", "BOU"…
#> $ FTHG     <dbl> 2, 1, 1, 2, 3, 2, 0, 2, 3, 0, 5, 1, 5, 4, 4, 0, 1, 1, 1, 2, 0…
#> $ FTAG     <dbl> 2, 1, 0, 2, 0, 3, 2, 0, 0, 0, 1, 0, 0, 2, 0, 4, 2, 1, 3, 3, 1…
#> $ FTR      <chr> "D", "D", "H", "D", "H", "A", "A", "H", "H", "D", "H", "H", "…
#> $ played   <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, T…
#> $ match    <chr> "241", "242", "243", "244", "245", "246", "247", "248", "249"…
```

The number of rows isn’t 380, as some games this season have yet to be
played and some games from last year didn’t feature all of our teams
from this season (as three teams were promoted from the Championship).

For reference, we can see the prevailing table.

``` r
example_thisSeason |> 
  calc_table_current() |> 
  print_table_current()
```

| Team | Played |  GD | Points |
|:-----|-------:|----:|-------:|
| LIV  |     35 |  46 |     82 |
| ARS  |     35 |  33 |     67 |
| MCI  |     35 |  24 |     64 |
| NEW  |     35 |  21 |     63 |
| CHE  |     35 |  21 |     63 |
| NOT  |     34 |  12 |     60 |
| AST  |     35 |   6 |     60 |
| BOU  |     35 |  13 |     53 |
| BRE  |     35 |   9 |     52 |
| BRI  |     35 |   1 |     52 |
| FUL  |     35 |   3 |     51 |
| CPA  |     34 |  -4 |     45 |
| WOL  |     35 | -11 |     41 |
| EVE  |     35 |  -7 |     39 |
| MUN  |     35 |  -9 |     39 |
| TOT  |     35 |   6 |     38 |
| WHU  |     35 | -19 |     37 |
| IPS  |     35 | -41 |     22 |
| LEI  |     35 | -47 |     21 |
| SOU  |     35 | -57 |     11 |

We can now model the strengths of the sides at home and away.

``` r
results_filtered |> 
  model_prepare_frame() |>
  model_run()
#> 
#> Call:
#> gnm::gnm(formula = count ~ -1 + s + draw, eliminate = match, 
#>     family = stats::quasipoisson, data = modelframe, start = rep(0, 
#>         2 * nTeams + 1))
#> 
#> Coefficients of interest:
#> sARS_home  sAST_home  sBOU_home  sBRE_home  sBRI_home  sCHE_home  sCPA_home  
#>    1.7940     1.7286     0.7238     0.8993     0.6519     2.1646     0.4254  
#> sEVE_home  sFUL_home  sIPS_home  sLEI_home  sLIV_home  sMCI_home  sMUN_home  
#>    0.3589     0.5613    -2.5243    -1.1832     3.1778     2.1444     0.3606  
#> sNEW_home  sNOT_home  sSOU_home  sTOT_home  sWHU_home  sWOL_home  sARS_away  
#>    1.6629     1.0210    -3.2596    -0.0165    -0.1080    -0.1318     1.7118  
#> sAST_away  sBOU_away  sBRE_away  sBRI_away  sCHE_away  sCPA_away  sEVE_away  
#>    0.2306     0.7772     0.5660     0.5618     1.0614     0.7559    -0.2114  
#> sFUL_away  sIPS_away  sLEI_away  sLIV_away  sMCI_away  sMUN_away  sNEW_away  
#>    0.6532    -0.3817    -1.7925     1.8694     1.3556    -0.1576     0.9152  
#> sNOT_away  sSOU_away  sTOT_away  sWHU_away  sWOL_away       draw  
#>    1.4112    -2.6533    -0.4861    -0.1094     0.1514         NA  
#> 
#> Deviance:            689.4529 
#> Pearson chi-squared: 768.8105 
#> Residual df:         722
```

\[I will add further details and more explanation in due course.\]
