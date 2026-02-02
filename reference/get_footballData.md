# Get the latest available results for the Premier League in a given season

This function retrieves the latest data on the Premier League results
for a given season.

## Usage

``` r
get_footballData(value_link, table_schedule, table_teams, value_yearEnd)
```

## Source

<https://www.football-data.co.uk>

## Arguments

- value_link:

  This is the link for the data on the web. For example, you could use
  'https://www.football-data.co.uk/mmz4281/2526/E0.csv'.

- table_schedule:

  This is the location of the schedule data, as generated through an
  in-built dataset or by using `get_openData_schedule`.

- table_teams:

  These are the teams in the season's Premier League, available as the
  `teams` dataset in this package.

- value_yearEnd:

  This is the integer required as the year in which the season ends.

## Examples

``` r
if (FALSE) { # \dontrun{
get_footballData(
  value_link = "https://www.football-data.co.uk/mmz4281/2526/E0.csv",
  table_schedule = schedule_thisSeason,
  table_teams = teams,
  value_yearEnd = 2026L
  )
} # }
```
