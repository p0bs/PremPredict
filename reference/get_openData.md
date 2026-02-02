# Get the latest available results for the Premier League in a given season

This function retrieves the latest data on the Premier League results
for a given season.

## Usage

``` r
get_openData(value_path, table_teams, value_yearEnd)
```

## Source

<https://github.com/openfootball/football.json>

## Arguments

- value_path:

  This is the location of the data on GitHub. See the example below for
  reference and use an address of the form,
  'https://raw.githubusercontent.com/openfootball/football.json/refs/heads/master/2024-25/en.1.json'.

- table_teams:

  These are the teams in the season's Premier League, available as the
  `teams` dataset in this package.

- value_yearEnd:

  This is the integer required as the year in which the season ends.

## Examples

``` r
if (FALSE) { # \dontrun{
get_openData(
  value_path = "https://raw.githubusercontent.com/openfootball/football.json/refs/etc",
  table_teams = teams,
  value_yearEnd = 2025L
  )
} # }
```
