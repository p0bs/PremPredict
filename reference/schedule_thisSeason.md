# A dataset containing the schedule of the Premier League this.

A dataset containing the schedule of the Premier League this.

## Usage

``` r
schedule_thisSeason
```

## Format

A data frame with many rows (one for each game this season) and 6
variables:

- number_match:

  A character of the index for the game in question

- number_match_integer:

  The integer version of `number_match`

- matchday:

  The date on which the game occurred

- homeTeam:

  The `shortName` of the team that played at home in the match

- awayTeam:

  The `shortName` of the team that played away in the match

- year_end:

  The calendar year in which the season ended

## Source

<https://github.com/openfootball/football.json>
