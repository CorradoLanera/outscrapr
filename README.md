
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

### Single query

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
#> 2 restaura… Uppe… Upper Dem Expr… ChIJBUW… 0x89c25d… 915 Utica A… East F… 915 U…
#> # ℹ 50 more variables: postal_code <chr>, area_service <lgl>,
#> #   country_code <chr>, country <chr>, city <chr>, us_state <chr>, state <chr>,
#> #   plus_code <lgl>, latitude <dbl>, longitude <dbl>, h3 <chr>,
#> #   time_zone <chr>, popular_times <lgl>, site <chr>, phone <chr>, type <chr>,
#> #   logo <chr>, description <lgl>, typical_time_spent <lgl>, located_in <lgl>,
#> #   located_google_id <lgl>, category <chr>, subtypes <chr>, posts <lgl>,
#> #   reviews_tags <lgl>, rating <dbl>, reviews <int>, photos_count <int>, …

restaurants$working_hours
#>          Sunday        Monday       Tuesday     Wednesday      Thursday
#> 1       12-10PM        4-10PM        4-10PM        4-10PM        4-10PM
#> 2 7:30AM-7:30PM 7:30AM-7:30PM 7:30AM-7:30PM 7:30AM-7:30PM 7:30AM-7:30PM
#>          Friday      Saturday
#> 1       4PM-1AM      12PM-1AM
#> 2 7:30AM-7:30PM 7:30AM-7:30PM
restaurants$about
#>   Service options.Curbside pickup Service options.No-contact delivery
#> 1                            TRUE                                TRUE
#> 2                              NA                                  NA
#>   Service options.Takeout Service options.Dine-in Service options.Delivery
#> 1                    TRUE                    TRUE                       NA
#> 2                    TRUE                    TRUE                     TRUE
#>   Fast service Popular for.Lunch Popular for.Dinner Popular for.Solo dining
#> 1         TRUE              TRUE               TRUE                    TRUE
#> 2           NA              TRUE               TRUE                    TRUE
#>   Wheelchair accessible entrance Offerings.Alcohol Offerings.Beer
#> 1                           TRUE              TRUE           TRUE
#> 2                           TRUE                NA             NA
#>   Offerings.Cocktails Offerings.Coffee Offerings.Comfort food
#> 1                TRUE             TRUE                   TRUE
#> 2                  NA               NA                   TRUE
#>   Offerings.Happy hour drinks Offerings.Hard liquor Offerings.Healthy options
#> 1                        TRUE                  TRUE                      TRUE
#> 2                          NA                    NA                        NA
#>   Offerings.Small plates Offerings.Wine Offerings.Quick bite
#> 1                   TRUE           TRUE                   NA
#> 2                   TRUE             NA                 TRUE
#>   Dining options.Brunch Dining options.Lunch Dining options.Dinner
#> 1                  TRUE                 TRUE                  TRUE
#> 2                    NA                 TRUE                  TRUE
#>   Dining options.Dessert Amenities.Bar onsite Amenities.Restroom
#> 1                   TRUE                 TRUE               TRUE
#> 2                     NA                   NA                 NA
#>   Atmosphere.Casual Atmosphere.Cozy Atmosphere.Trendy Groups
#> 1              TRUE            TRUE              TRUE   TRUE
#> 2              TRUE              NA                NA     NA
#>   Accepts reservations Payments.Credit cards Payments.NFC mobile payments
#> 1                 TRUE                  TRUE                           NA
#> 2                   NA                  TRUE                         TRUE
#>   Parking.Free street parking Parking.Parking Good for kids
#> 1                        TRUE            TRUE            NA
#> 2                          NA              NA          TRUE
restaurants$about$`Popular for`
#>   Lunch Dinner Solo dining
#> 1  TRUE   TRUE        TRUE
#> 2  TRUE   TRUE        TRUE
restaurants$reviews_per_score
#>    1 2 3  4   5
#> 1 10 6 6 20 215
#> 2  0 1 1  2  24
```

### Multiple queries

You can retrieve max 500 places per one query search on Google Maps. For
densely populated areas you might want to split your query into
subqueries in order to get all the places inside. (e.g.,
`c("restaurants, Brooklyn 11211", "restaurants, Brooklyn 11215")`).

``` r
queries <- c(
  "restaurants, Brooklyn 11211",
  "restaurants, Brooklyn 11215"
)

# Results' limit refers to the number of places to retrieve for each
# query. The results of all queries are combined into a single tibble.
multi_restaurants <- google_maps_search(query = queries, limit = 2)
multi_restaurants
#> # A tibble: 4 × 58
#>   query     name  name_for_emails place_id google_id full_address borough street
#>   <chr>     <chr> <chr>           <chr>    <chr>     <chr>        <chr>   <chr> 
#> 1 restaura… The … The Commodore   ChIJpwY… 0x89c259… 366 Metropo… Willia… 366 M…
#> 2 restaura… Lilia Lilia           ChIJJXC… 0x89c259… 567 Union A… Willia… 567 U…
#> 3 restaura… Chela Chela           ChIJ3Vk… 0x89c25a… 408 5th Ave… Park S… 408 5…
#> 4 restaura… The … The Common Par… ChIJR-z… 0x89c25b… 548 4th Ave… Gowanus 548 4…
#> # ℹ 50 more variables: postal_code <chr>, area_service <lgl>,
#> #   country_code <chr>, country <chr>, city <chr>, us_state <chr>, state <chr>,
#> #   plus_code <lgl>, latitude <dbl>, longitude <dbl>, h3 <chr>,
#> #   time_zone <chr>, popular_times <lgl>, site <chr>, phone <chr>, type <chr>,
#> #   logo <chr>, description <chr>, typical_time_spent <lgl>, located_in <lgl>,
#> #   located_google_id <lgl>, category <chr>, subtypes <chr>, posts <lgl>,
#> #   reviews_tags <lgl>, rating <dbl>, reviews <int>, photos_count <int>, …
multi_restaurants$working_hours
#>          Sunday        Monday                Tuesday              Wednesday
#> 1      11AM-4AM       4PM-4AM                4PM-4AM                4PM-4AM
#> 2      4-9:30PM      5-9:30PM               5-9:30PM               5-9:30PM
#> 3     11AM-10PM       12-10PM                12-10PM                12-10PM
#> 4 8:30AM-3:30PM 8:30AM-3:30PM 8:30AM-3:30PM,5-9:30PM 8:30AM-3:30PM,5-9:30PM
#>        Thursday                 Friday      Saturday
#> 1       4PM-4AM                4PM-4AM      11AM-4AM
#> 2      5-9:30PM               4-9:30PM      4-9:30PM
#> 3       12-10PM                12-11PM     11AM-11PM
#> 4 8:30AM-3:30PM 8:30AM-3:30PM,5-9:30PM 8:30AM-3:30PM
multi_restaurants$about
#>   Service options.Outdoor seating Service options.Delivery
#> 1                            TRUE                     TRUE
#> 2                            TRUE                    FALSE
#> 3                            TRUE                     TRUE
#> 4                              NA                     TRUE
#>   Service options.Takeout Service options.Dine-in
#> 1                    TRUE                    TRUE
#> 2                    TRUE                    TRUE
#> 3                    TRUE                    TRUE
#> 4                    TRUE                    TRUE
#>   Service options.Curbside pickup Service options.No-contact delivery
#> 1                              NA                                  NA
#> 2                              NA                                  NA
#> 3                            TRUE                                TRUE
#> 4                            TRUE                                TRUE
#>   Highlights.Fast service Highlights.Great coffee Highlights.Great dessert
#> 1                    TRUE                      NA                       NA
#> 2                      NA                    TRUE                     TRUE
#> 3                    TRUE                      NA                       NA
#> 4                    TRUE                    TRUE                       NA
#>   Highlights.Live music Popular for.Lunch Popular for.Dinner
#> 1                    NA              TRUE               TRUE
#> 2                    NA              TRUE               TRUE
#> 3                  TRUE              TRUE               TRUE
#> 4                    NA              TRUE               TRUE
#>   Popular for.Solo dining Popular for.Breakfast
#> 1                    TRUE                    NA
#> 2                    TRUE                    NA
#> 3                    TRUE                    NA
#> 4                    TRUE                  TRUE
#>   Accessibility.Wheelchair accessible entrance
#> 1                                         TRUE
#> 2                                         TRUE
#> 3                                         TRUE
#> 4                                         TRUE
#>   Accessibility.Wheelchair accessible seating
#> 1                                        TRUE
#> 2                                        TRUE
#> 3                                        TRUE
#> 4                                        TRUE
#>   Accessibility.Wheelchair accessible parking lot
#> 1                                           FALSE
#> 2                                           FALSE
#> 3                                           FALSE
#> 4                                           FALSE
#>   Accessibility.Wheelchair accessible restroom Offerings.Alcohol Offerings.Beer
#> 1                                           NA              TRUE           TRUE
#> 2                                         TRUE              TRUE           TRUE
#> 3                                         TRUE              TRUE           TRUE
#> 4                                         TRUE              TRUE           TRUE
#>   Offerings.Cocktails Offerings.Comfort food Offerings.Happy hour drinks
#> 1                TRUE                   TRUE                        TRUE
#> 2                TRUE                   TRUE                          NA
#> 3                TRUE                   TRUE                        TRUE
#> 4                  NA                   TRUE                          NA
#>   Offerings.Hard liquor Offerings.Late-night food Offerings.Quick bite
#> 1                  TRUE                      TRUE                 TRUE
#> 2                  TRUE                      TRUE                   NA
#> 3                  TRUE                      TRUE                 TRUE
#> 4                    NA                        NA                 TRUE
#>   Offerings.Small plates Offerings.Vegetarian options Offerings.Wine
#> 1                   TRUE                         TRUE           TRUE
#> 2                   TRUE                         TRUE           TRUE
#> 3                   TRUE                         TRUE           TRUE
#> 4                     NA                           NA           TRUE
#>   Offerings.Coffee Offerings.Happy hour food Offerings.Healthy options
#> 1               NA                        NA                        NA
#> 2             TRUE                        NA                        NA
#> 3             TRUE                      TRUE                      TRUE
#> 4             TRUE                        NA                        NA
#>   Dining options.Breakfast Dining options.Brunch Dining options.Lunch
#> 1                     TRUE                  TRUE                 TRUE
#> 2                       NA                  TRUE                 TRUE
#> 3                     TRUE                  TRUE                 TRUE
#> 4                     TRUE                  TRUE                 TRUE
#>   Dining options.Dinner Dining options.Seating Dining options.Dessert
#> 1                  TRUE                   TRUE                     NA
#> 2                  TRUE                   TRUE                   TRUE
#> 3                  TRUE                   TRUE                   TRUE
#> 4                  TRUE                   TRUE                   TRUE
#>   Dining options.Catering Dining options.Counter service Amenities.Bar onsite
#> 1                      NA                             NA                 TRUE
#> 2                      NA                             NA                 TRUE
#> 3                    TRUE                             NA                 TRUE
#> 4                    TRUE                           TRUE                 TRUE
#>   Amenities.Restroom Amenities.Wi-Fi Atmosphere.Casual Atmosphere.Cozy
#> 1               TRUE              NA              TRUE            TRUE
#> 2               TRUE              NA                NA            TRUE
#> 3               TRUE            TRUE              TRUE            TRUE
#> 4               TRUE              NA              TRUE            TRUE
#>   Atmosphere.Trendy Atmosphere.Romantic Atmosphere.Trending Atmosphere.Upscale
#> 1              TRUE                  NA                  NA                 NA
#> 2              TRUE                TRUE                TRUE               TRUE
#> 3              TRUE                  NA                TRUE                 NA
#> 4              TRUE                  NA                  NA                 NA
#>   Crowd.College students Crowd.Groups Crowd.Tourists Crowd.Family-friendly
#> 1                   TRUE         TRUE           TRUE                    NA
#> 2                     NA         TRUE           TRUE                    NA
#> 3                     NA         TRUE           TRUE                  TRUE
#> 4                     NA           NA             NA                  TRUE
#>   Crowd.LGBTQ+ friendly Crowd.Transgender safespace
#> 1                    NA                          NA
#> 2                    NA                          NA
#> 3                  TRUE                        TRUE
#> 4                  TRUE                          NA
#>   Planning.Accepts reservations Planning.Reservations required
#> 1                         FALSE                             NA
#> 2                          TRUE                           TRUE
#> 3                          TRUE                             NA
#> 4                          TRUE                             NA
#>   Planning.Dinner reservations recommended Planning.Usually a wait
#> 1                                       NA                      NA
#> 2                                     TRUE                    TRUE
#> 3                                     TRUE                      NA
#> 4                                       NA                      NA
#>   Payments.Credit cards Payments.Debit cards Payments.NFC mobile payments
#> 1                  TRUE                 TRUE                         TRUE
#> 2                  TRUE                 TRUE                         TRUE
#> 3                  TRUE                 TRUE                         TRUE
#> 4                  TRUE                 TRUE                         TRUE
#>   Parking.Free street parking Parking.Paid street parking Parking.Parking
#> 1                        TRUE                        TRUE            TRUE
#> 2                        TRUE                          NA            TRUE
#> 3                          NA                          NA              NA
#> 4                          NA                          NA              NA
#>   From the business.Identifies as Latino-owned
#> 1                                           NA
#> 2                                           NA
#> 3                                         TRUE
#> 4                                           NA
#>   From the business.Identifies as women-owned Children.Good for kids
#> 1                                          NA                     NA
#> 2                                          NA                     NA
#> 3                                        TRUE                   TRUE
#> 4                                          NA                   TRUE
#>   Children.High chairs Children.Kids' menu Other.LGBTQ+ friendly
#> 1                   NA                  NA                    NA
#> 2                   NA                  NA                    NA
#> 3                 TRUE                TRUE                  TRUE
#> 4                 TRUE                  NA                  TRUE
#>   Other.Identifies as women-owned Other.Identifies as Latino-owned
#> 1                              NA                               NA
#> 2                              NA                               NA
#> 3                            TRUE                             TRUE
#> 4                              NA                               NA
multi_restaurants$about$Highlights
#>   Fast service Great coffee Great dessert Live music
#> 1         TRUE           NA            NA         NA
#> 2           NA         TRUE          TRUE         NA
#> 3         TRUE           NA            NA       TRUE
#> 4         TRUE         TRUE            NA         NA
multi_restaurants$reviews_per_score
#>     1  2   3   4    5
#> 1  67 35  57 292  807
#> 2 117 62 161 274 1228
#> 3  30 32  67 171  857
#> 4   1  0   4   5  112
```

## Code of Conduct

Please note that the outscrapr project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
