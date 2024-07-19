
<!-- README.md is generated from README.Rmd. Please edit that file -->

# outscrapr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/CorradoLanera/outscrapr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/CorradoLanera/outscrapr?branch=main)
[![test-coverage](https://github.com/CorradoLanera/outscrapr/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/CorradoLanera/outscrapr/actions/workflows/test-coverage.yaml)
[![R-CMD-check](https://github.com/CorradoLanera/outscrapr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/CorradoLanera/outscrapr/actions/workflows/R-CMD-check.yaml)
[![R-CMD-checkdev](https://github.com/CorradoLanera/outscrapr/actions/workflows/R-CMD-checkdev.yaml/badge.svg)](https://github.com/CorradoLanera/outscrapr/actions/workflows/R-CMD-checkdev.yaml)
<!-- badges: end -->

The goal of `{outscrapr}` is to implement a simplified subset of the
[Outscraper](https://outscraper.com/) API in R.

## Installation

You can install the development version of `{outscrapr}` like so:

``` r
devtools::install_github("CorradoLanera/outscrapr")
```

## Places

``` r
library(outscrapr)

# Get your API key from https://outscraper.com/ and set it as the environment variable `OUTSCRAPER_API_KEY`
query <- "restaurants, Brooklyn 11203"

restaurants <- google_maps_search(query = query, limit = 2)

restaurants
#> # A tibble: 2 × 58
#>   query     name  name_for_emails place_id google_id full_address borough street
#>   <chr>     <chr> <chr>           <chr>    <chr>     <chr>        <chr>   <chr> 
#> 1 restaura… LILL… Lilli Restaura… ChIJU4x… 0x89c25d… 1344 Utica … East F… 1344 …
#> 2 restaura… Cook… Cooklyn Eats Bk ChIJK_V… 0x89c25b… 2831 Church… Little… 2831 …
#> # ℹ 50 more variables: postal_code <chr>, area_service <lgl>,
#> #   country_code <chr>, country <chr>, city <chr>, us_state <chr>, state <chr>,
#> #   plus_code <lgl>, latitude <dbl>, longitude <dbl>, h3 <chr>,
#> #   time_zone <chr>, popular_times <lgl>, site <chr>, phone <chr>, type <chr>,
#> #   logo <chr>, description <lgl>, typical_time_spent <lgl>, located_in <lgl>,
#> #   located_google_id <lgl>, category <chr>, subtypes <chr>, posts <lgl>,
#> #   reviews_tags <lgl>, rating <dbl>, reviews <int>, photos_count <int>, …

restaurants$working_hours
#>    Sunday  Monday Tuesday Wednesday Thursday  Friday Saturday
#> 1 12-10PM  4-10PM  4-10PM    4-10PM   4-10PM 4PM-1AM 12PM-1AM
#> 2 6AM-3AM 6AM-3AM 6AM-3AM   6AM-3AM  6AM-3AM 6AM-3AM  6AM-3AM
restaurants$about
#>   Service options.Curbside pickup Service options.No-contact delivery
#> 1                            TRUE                                TRUE
#> 2                              NA                                TRUE
#>   Service options.Takeout Service options.Dine-in Service options.Delivery
#> 1                    TRUE                    TRUE                       NA
#> 2                    TRUE                      NA                     TRUE
#>   Fast service Popular for.Lunch Popular for.Dinner Popular for.Solo dining
#> 1         TRUE              TRUE               TRUE                    TRUE
#> 2           NA              TRUE               TRUE                    TRUE
#>   Popular for.Breakfast Wheelchair accessible entrance Offerings.Alcohol
#> 1                    NA                           TRUE              TRUE
#> 2                  TRUE                             NA                NA
#>   Offerings.Beer Offerings.Cocktails Offerings.Coffee Offerings.Comfort food
#> 1           TRUE                TRUE             TRUE                   TRUE
#> 2             NA                  NA               NA                   TRUE
#>   Offerings.Happy hour drinks Offerings.Hard liquor Offerings.Healthy options
#> 1                        TRUE                  TRUE                      TRUE
#> 2                          NA                    NA                        NA
#>   Offerings.Small plates Offerings.Wine Offerings.Quick bite
#> 1                   TRUE           TRUE                   NA
#> 2                   TRUE             NA                 TRUE
#>   Dining options.Brunch Dining options.Lunch Dining options.Dinner
#> 1                  TRUE                 TRUE                  TRUE
#> 2                    NA                 TRUE                  TRUE
#>   Dining options.Dessert Dining options.Breakfast Amenities.Bar onsite
#> 1                   TRUE                       NA                 TRUE
#> 2                   TRUE                     TRUE                   NA
#>   Amenities.Restroom Atmosphere.Casual Atmosphere.Cozy Atmosphere.Trendy Groups
#> 1               TRUE              TRUE            TRUE              TRUE   TRUE
#> 2                 NA              TRUE              NA                NA     NA
#>   Accepts reservations Credit cards Parking.Free street parking Parking.Parking
#> 1                 TRUE         TRUE                        TRUE            TRUE
#> 2                   NA         TRUE                        TRUE            TRUE
#>   Parking.Free parking lot
#> 1                       NA
#> 2                     TRUE
restaurants$about$`Popular for`
#>   Lunch Dinner Solo dining Breakfast
#> 1  TRUE   TRUE        TRUE        NA
#> 2  TRUE   TRUE        TRUE      TRUE
restaurants$reviews_per_score
#>    1 2 3  4   5
#> 1 10 6 6 20 215
#> 2  4 1 3 10 126
```

## Code of Conduct

Please note that the outscrapr project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
