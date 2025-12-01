# Code Review

## high-priority issues
- **External data ingestion lacks validation and resilience.** `get_openData()` trusts the JSON structure and status of remote `value_path` without HTTP error handling, schema checks, or fallbacks; malformed or rate-limited responses will propagate `NA` rows or errors before joins filter them out. Consider using `{httr2}` with explicit status checks, timeouts, and a small schema validator before the joins, and surface informative errors when required columns are missing. 【F:R/get_openData.R†L21-L61】
- **`run_simulations()` keeps an unused dataset load.** The call to `utils::data("example_thisSeason")` is not used downstream, adds unnecessary I/O, and may raise an R CMD check NOTE for an unused dataset. Remove it or replace with an explicit argument/option when example data are required. 【F:R/run_simulations.R†L161-L177】
- **Latest-game detection can return empty results.** `calc_game_latest()` slices the most recent played match but does not guard against a season with zero `played` rows, returning `numeric(0)` and risking downstream errors (e.g., in `get_results_filtered`). Add a defensive check that aborts with a clear message or returns `NA_integer_` when no matches are available. 【F:R/calc_game_latest.R†L16-L25】

## improvements
- **Tighten factor validation for results.** `run_simulations()` requires `FTR` to be a factor but never checks the levels; unexpected factor levels (e.g., lowercase or extras) will bypass validation and skew the model matrices. Add an explicit level set and abort on mismatches to prevent silent recycling. 【F:R/run_simulations.R†L107-L158】
- **CSV ingest defaults may misparse.** `get_footballData()` relies on `readr::read_csv()` type guessing and lacks column existence checks, which can yield silent coercions when the upstream schema shifts. Specify `col_types`, confirm expected columns, and emit actionable errors for missing fields to reduce brittleness. 【F:R/get_footballData.R†L21-L48】
- **Missing reproducibility guidance.** The README installs via `{pak}` but the project does not ship a lockfile (e.g., `{renv}`) or documented session info, making it hard to reproduce simulations across R versions. Consider adding an `renv.lock` and short setup notes in the README/pkgdown site.
- **Test coverage gaps for I/O paths.** The current tests check `get_openData()` row/column counts but do not exercise error paths (bad URLs, bad schemas) or network-free mocks. Add `{httptest2}`/fixtures to cover failure scenarios and strengthen CI confidence for CRAN/network policies. 【F:tests/testthat/test-get_openData.R†L1-L35】

## nice-to-have enhancements
- **Namespace minimization.** Several helpers could use base R (e.g., `sprintf`, `matrix`) or existing imports without repeatedly qualifying via `dplyr::` chains; auditing imports vs. usage could shrink the `Imports` footprint and speed installs. 【F:DESCRIPTION†L17-L30】【F:R/model_prepare_frame.R†L17-L37】
- **User-facing messaging.** When filtering out teams absent from `table_teams` in `get_openData()`, consider emitting a warning listing dropped fixtures so users notice mapping issues rather than silently losing rows. 【F:R/get_openData.R†L37-L59】
- **Pkgdown/README alignment.** The README describes an example but the pkgdown site config is not referenced; adding pkgdown build status to badges and ensuring examples are executed during docs builds would improve UX. 【F:README.md†L1-L74】【F:_pkgdown.yml†L1-L65】

## automated checklist
- [ ] Functions validated and exported correctly
- [ ] roxygen documentation complete
- [ ] Namespace minimal and accurate
- [ ] Tests cover >80% of code
- [ ] No R CMD check warnings/notes
- [ ] Dependencies minimal and justified
- [ ] CI workflows pass successfully
- [ ] pkgdown builds cleanly
