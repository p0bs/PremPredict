# A dataset containing the results of the Premier League from previous seasons.

A dataset containing the results of the Premier League from previous
seasons.

## Usage

``` r
previous_seasons
```

## Format

A data frame with many rows (one for each game in recent history that
involves two current Premier League teams) and 10 variables:

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

- FTHG:

  The goals scored by the team that played at home in the match

- FTAG:

  The goals scored by the team that played away in the match

- FTR:

  The result of the match, as a factor of "A" (away win), "D" (draw) or
  "H" (home win)

- played:

  A logical indicating if this game has been played yet

- year_end:

  The calendar year in which the season ended

## Source

<https://github.com/openfootball/football.json>
