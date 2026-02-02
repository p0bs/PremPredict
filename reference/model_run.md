# Run the prediction model

This function takes the relevant filtered results from the Premier
League and uses them to model each team's capabilities, both at home and
away.

## Usage

``` r
model_run(modelframe)
```

## Arguments

- modelframe:

  This is the modelframe generated in `model_prepare_frame`.

## Examples

``` r
if (FALSE) { # \dontrun{
model_run(
  modelframe = data_modelframe
  )
} # }
```
