
<!-- README.md is generated from README.Rmd. Please edit that file -->

# outscrapr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![lint](https://github.com/CorradoLanera/outscrapr/actions/workflows/lint.yaml/badge.svg)](https://github.com/CorradoLanera/outscrapr/actions/workflows/lint.yaml)
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
#> 1 restaura… D Ga… D Garden Carib… ChIJPdh… 0x89c25d… 4617 Avenue… Little… 4617 …
#> 2 restaura… Foot… Footprints Cafe ChIJxUl… 0x89c25c… 5814 Claren… East F… 5814 …
#> # ℹ 50 more variables: postal_code <chr>, area_service <lgl>,
#> #   country_code <chr>, country <chr>, city <chr>, us_state <chr>, state <chr>,
#> #   plus_code <lgl>, latitude <dbl>, longitude <dbl>, h3 <chr>,
#> #   time_zone <chr>, popular_times <lgl>, site <chr>, phone <chr>, type <chr>,
#> #   logo <chr>, description <chr>, typical_time_spent <lgl>, located_in <lgl>,
#> #   located_google_id <lgl>, category <chr>, subtypes <chr>, posts <lgl>,
#> #   reviews_tags <lgl>, rating <dbl>, reviews <int>, photos_count <int>, …

restaurants$working_hours
#>      Sunday    Monday   Tuesday Wednesday  Thursday   Friday Saturday
#> 1  12PM-2AM  3PM-12AM  3PM-12AM  3PM-12AM  3PM-12AM 3PM-12AM 12PM-2AM
#> 2 11AM-12AM 11AM-12AM 11AM-12AM 11AM-12AM 11AM-12AM 11AM-2AM 11AM-2AM
restaurants$about
#>   Service options.Outdoor seating Service options.No-contact delivery
#> 1                            TRUE                                TRUE
#> 2                            TRUE                                  NA
#>   Service options.Delivery Service options.Takeout Service options.Dine-in
#> 1                     TRUE                    TRUE                    TRUE
#> 2                     TRUE                    TRUE                    TRUE
#>   Highlights.Fast service Highlights.Great beer selection
#> 1                    TRUE                            TRUE
#> 2                    TRUE                              NA
#>   Highlights.Great cocktails Highlights.Sports Highlights.Great dessert
#> 1                       TRUE              TRUE                       NA
#> 2                       TRUE              TRUE                     TRUE
#>   Highlights.Live music Popular for.Lunch Popular for.Dinner
#> 1                    NA              TRUE               TRUE
#> 2                  TRUE              TRUE               TRUE
#>   Popular for.Solo dining Accessibility.Wheelchair accessible entrance
#> 1                    TRUE                                         TRUE
#> 2                    TRUE                                         TRUE
#>   Accessibility.Wheelchair accessible restroom
#> 1                                         TRUE
#> 2                                         TRUE
#>   Accessibility.Wheelchair accessible seating Offerings.Alcohol Offerings.Beer
#> 1                                        TRUE              TRUE           TRUE
#> 2                                        TRUE              TRUE           TRUE
#>   Offerings.Cocktails Offerings.Comfort food Offerings.Happy hour drinks
#> 1                TRUE                   TRUE                        TRUE
#> 2                TRUE                   TRUE                        TRUE
#>   Offerings.Hard liquor Offerings.Late-night food Offerings.Small plates
#> 1                  TRUE                      TRUE                   TRUE
#> 2                  TRUE                      TRUE                   TRUE
#>   Offerings.Wine Offerings.Coffee Offerings.Happy hour food
#> 1           TRUE               NA                        NA
#> 2           TRUE             TRUE                      TRUE
#>   Offerings.Healthy options Offerings.Quick bite Offerings.Vegan options
#> 1                        NA                   NA                      NA
#> 2                      TRUE                 TRUE                    TRUE
#>   Offerings.Vegetarian options Dining options.Brunch Dining options.Lunch
#> 1                           NA                  TRUE                 TRUE
#> 2                         TRUE                  TRUE                 TRUE
#>   Dining options.Dinner Dining options.Dessert Dining options.Seating
#> 1                  TRUE                   TRUE                   TRUE
#> 2                  TRUE                   TRUE                   TRUE
#>   Dining options.Catering Amenities.Bar onsite Amenities.Restroom
#> 1                      NA                 TRUE               TRUE
#> 2                    TRUE                 TRUE               TRUE
#>   Atmosphere.Casual Atmosphere.Cozy Atmosphere.Trendy Crowd.Groups
#> 1              TRUE            TRUE              TRUE         TRUE
#> 2              TRUE            TRUE              TRUE         TRUE
#>   Crowd.College students Crowd.Tourists Planning.Accepts reservations
#> 1                     NA             NA                          TRUE
#> 2                   TRUE           TRUE                          TRUE
#>   Planning.Usually a wait Payments.Credit cards Payments.Debit cards
#> 1                      NA                  TRUE                 TRUE
#> 2                    TRUE                  TRUE                 TRUE
#>   Payments.NFC mobile payments Parking.Free street parking
#> 1                         TRUE                        TRUE
#> 2                           NA                        TRUE
#>   Parking.Free parking lot Parking.Parking High chairs
#> 1                       NA              NA          NA
#> 2                     TRUE            TRUE        TRUE
restaurants$about$`Popular for`
#>   Lunch Dinner Solo dining
#> 1  TRUE   TRUE        TRUE
#> 2  TRUE   TRUE        TRUE
restaurants$reviews_per_score
#>     1   2   3    4    5
#> 1  25  13  13   27  164
#> 2 496 186 421 1015 2239
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
#> 2 restaura… Lase… Laser Wolf Bro… ChIJLyS… 0x89c259… 97 Wythe Av… Willia… 97 Wy…
#> 3 restaura… Alch… Alchemy         ChIJD4O… 0x89c25b… 56 5th Ave,… Park S… 56 5t…
#> 4 restaura… Chela Chela           ChIJ3Vk… 0x89c25a… 408 5th Ave… Park S… 408 5…
#> # ℹ 50 more variables: postal_code <chr>, area_service <lgl>,
#> #   country_code <chr>, country <chr>, city <chr>, us_state <chr>, state <chr>,
#> #   plus_code <lgl>, latitude <dbl>, longitude <dbl>, h3 <chr>,
#> #   time_zone <chr>, popular_times <lgl>, site <chr>, phone <chr>, type <chr>,
#> #   logo <chr>, description <chr>, typical_time_spent <lgl>, located_in <lgl>,
#> #   located_google_id <lgl>, category <chr>, subtypes <chr>, posts <lgl>,
#> #   reviews_tags <lgl>, rating <dbl>, reviews <int>, photos_count <int>, …
multi_restaurants$working_hours
#>          Sunday       Monday      Tuesday    Wednesday     Thursday
#> 1      11AM-4AM      4PM-4AM      4PM-4AM      4PM-4AM      4PM-4AM
#> 2 12-3PM,5-11PM       5-11PM       5-11PM       5-11PM      5PM-1AM
#> 3     10AM-12AM 11:30AM-12AM 11:30AM-12AM 11:30AM-12AM 11:30AM-12AM
#> 4     11AM-10PM      12-10PM      12-10PM      12-10PM      12-10PM
#>         Friday       Saturday
#> 1      4PM-4AM       11AM-4AM
#> 2      5PM-1AM 12-3PM,5PM-1AM
#> 3 11:30AM-12AM   10AM-11:30PM
#> 4      12-11PM      11AM-11PM
multi_restaurants$about
#>   Service options.Outdoor seating Service options.Delivery
#> 1                            TRUE                     TRUE
#> 2                            TRUE                    FALSE
#> 3                            TRUE                     TRUE
#> 4                            TRUE                     TRUE
#>   Service options.Takeout Service options.Dine-in
#> 1                    TRUE                    TRUE
#> 2                   FALSE                    TRUE
#> 3                    TRUE                    TRUE
#> 4                    TRUE                    TRUE
#>   Service options.Curbside pickup Service options.No-contact delivery
#> 1                              NA                                  NA
#> 2                              NA                                  NA
#> 3                              NA                                  NA
#> 4                            TRUE                                TRUE
#>   Highlights.Fast service Highlights.Rooftop seating Highlights.Live music
#> 1                    TRUE                         NA                    NA
#> 2                      NA                       TRUE                    NA
#> 3                    TRUE                         NA                    NA
#> 4                    TRUE                         NA                  TRUE
#>   Popular for.Lunch Popular for.Dinner Popular for.Solo dining
#> 1              TRUE               TRUE                    TRUE
#> 2              TRUE               TRUE                      NA
#> 3              TRUE               TRUE                    TRUE
#> 4              TRUE               TRUE                    TRUE
#>   Popular for.Breakfast Accessibility.Wheelchair accessible entrance
#> 1                    NA                                         TRUE
#> 2                    NA                                         TRUE
#> 3                  TRUE                                         TRUE
#> 4                    NA                                         TRUE
#>   Accessibility.Wheelchair accessible seating
#> 1                                        TRUE
#> 2                                        TRUE
#> 3                                        TRUE
#> 4                                        TRUE
#>   Accessibility.Wheelchair accessible parking lot
#> 1                                           FALSE
#> 2                                              NA
#> 3                                           FALSE
#> 4                                           FALSE
#>   Accessibility.Wheelchair accessible restroom Offerings.Alcohol Offerings.Beer
#> 1                                           NA              TRUE           TRUE
#> 2                                         TRUE              TRUE           TRUE
#> 3                                         TRUE              TRUE           TRUE
#> 4                                         TRUE              TRUE           TRUE
#>   Offerings.Cocktails Offerings.Comfort food Offerings.Happy hour drinks
#> 1                TRUE                   TRUE                        TRUE
#> 2                TRUE                     NA                          NA
#> 3                TRUE                   TRUE                        TRUE
#> 4                TRUE                   TRUE                        TRUE
#>   Offerings.Hard liquor Offerings.Late-night food Offerings.Quick bite
#> 1                  TRUE                      TRUE                 TRUE
#> 2                  TRUE                      TRUE                   NA
#> 3                  TRUE                      TRUE                 TRUE
#> 4                  TRUE                      TRUE                 TRUE
#>   Offerings.Small plates Offerings.Vegetarian options Offerings.Wine
#> 1                   TRUE                         TRUE           TRUE
#> 2                   TRUE                           NA           TRUE
#> 3                   TRUE                           NA           TRUE
#> 4                   TRUE                         TRUE           TRUE
#>   Offerings.Coffee Offerings.Happy hour food Offerings.Organic dishes
#> 1               NA                        NA                       NA
#> 2             TRUE                        NA                       NA
#> 3             TRUE                      TRUE                     TRUE
#> 4             TRUE                      TRUE                       NA
#>   Offerings.Healthy options Dining options.Breakfast Dining options.Brunch
#> 1                        NA                     TRUE                  TRUE
#> 2                        NA                       NA                  TRUE
#> 3                        NA                     TRUE                  TRUE
#> 4                      TRUE                     TRUE                  TRUE
#>   Dining options.Lunch Dining options.Dinner Dining options.Seating
#> 1                 TRUE                  TRUE                   TRUE
#> 2                 TRUE                  TRUE                   TRUE
#> 3                 TRUE                  TRUE                   TRUE
#> 4                 TRUE                  TRUE                   TRUE
#>   Dining options.Dessert Dining options.Catering Amenities.Bar onsite
#> 1                     NA                      NA                 TRUE
#> 2                   TRUE                      NA                 TRUE
#> 3                   TRUE                      NA                 TRUE
#> 4                   TRUE                    TRUE                 TRUE
#>   Amenities.Restroom Amenities.Wi-Fi Atmosphere.Casual Atmosphere.Cozy
#> 1               TRUE              NA              TRUE            TRUE
#> 2               TRUE              NA                NA            TRUE
#> 3               TRUE              NA              TRUE            TRUE
#> 4               TRUE            TRUE              TRUE            TRUE
#>   Atmosphere.Trendy Atmosphere.Romantic Atmosphere.Upscale Atmosphere.Trending
#> 1              TRUE                  NA                 NA                  NA
#> 2              TRUE                TRUE               TRUE                  NA
#> 3              TRUE                  NA                 NA                  NA
#> 4              TRUE                  NA                 NA                TRUE
#>   Crowd.College students Crowd.Groups Crowd.Tourists Crowd.Family-friendly
#> 1                   TRUE         TRUE           TRUE                    NA
#> 2                     NA         TRUE           TRUE                    NA
#> 3                     NA         TRUE             NA                    NA
#> 4                     NA         TRUE           TRUE                  TRUE
#>   Crowd.LGBTQ+ friendly Crowd.Transgender safespace
#> 1                    NA                          NA
#> 2                    NA                          NA
#> 3                    NA                          NA
#> 4                  TRUE                        TRUE
#>   Planning.Accepts reservations Planning.Reservations required
#> 1                         FALSE                             NA
#> 2                          TRUE                           TRUE
#> 3                            NA                             NA
#> 4                          TRUE                             NA
#>   Planning.Dinner reservations recommended Planning.Usually a wait
#> 1                                       NA                      NA
#> 2                                     TRUE                    TRUE
#> 3                                       NA                      NA
#> 4                                     TRUE                      NA
#>   Payments.Credit cards Payments.Debit cards Payments.NFC mobile payments
#> 1                  TRUE                 TRUE                         TRUE
#> 2                  TRUE                 TRUE                           NA
#> 3                  TRUE                 TRUE                         TRUE
#> 4                  TRUE                 TRUE                         TRUE
#>   Parking.Free street parking Parking.Paid street parking Parking.Parking
#> 1                        TRUE                        TRUE            TRUE
#> 2                          NA                          NA              NA
#> 3                          NA                          NA              NA
#> 4                          NA                          NA              NA
#>   Children.Kids' menu Children.Good for kids Children.High chairs
#> 1                  NA                     NA                   NA
#> 2                  NA                     NA                   NA
#> 3                TRUE                     NA                   NA
#> 4                TRUE                   TRUE                 TRUE
#>   From the business.Identifies as Latino-owned
#> 1                                           NA
#> 2                                           NA
#> 3                                           NA
#> 4                                         TRUE
#>   From the business.Identifies as women-owned Other.LGBTQ+ friendly
#> 1                                          NA                    NA
#> 2                                          NA                    NA
#> 3                                          NA                    NA
#> 4                                        TRUE                  TRUE
#>   Other.Identifies as women-owned Other.Identifies as Latino-owned
#> 1                              NA                               NA
#> 2                              NA                               NA
#> 3                              NA                               NA
#> 4                            TRUE                             TRUE
multi_restaurants$about$Highlights
#>   Fast service Rooftop seating Live music
#> 1         TRUE              NA         NA
#> 2           NA            TRUE         NA
#> 3         TRUE              NA         NA
#> 4         TRUE              NA       TRUE
multi_restaurants$reviews_per_score
#>    1  2  3   4   5
#> 1 67 35 57 292 807
#> 2 51 13 31  72 462
#> 3 18 17 62 213 447
#> 4 30 32 67 171 857
```

## Code of Conduct

Please note that the outscrapr project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
