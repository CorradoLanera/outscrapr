
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

# Get your API key from https://outscraper.com/ and set it as the
# environment variable `OUTSCRAPER_API_KEY`
query <- "restaurants, Brooklyn 11203"

restaurants <- google_maps_search(query = query, limit = 2)

restaurants
#> # A tibble: 2 × 58
#>   query     name  name_for_emails place_id google_id full_address borough street
#>   <chr>     <chr> <chr>           <chr>    <chr>     <chr>        <chr>   <chr> 
#> 1 restaura… Suede Suede           ChIJCzJ… 0x89c25c… 5610 Claren… East F… 5610 …
#> 2 restaura… LILL… Lilli Restaura… ChIJU4x… 0x89c25d… 1344 Utica … East F… 1344 …
#> # ℹ 50 more variables: postal_code <chr>, area_service <lgl>,
#> #   country_code <chr>, country <chr>, city <chr>, us_state <chr>, state <chr>,
#> #   plus_code <lgl>, latitude <dbl>, longitude <dbl>, h3 <chr>,
#> #   time_zone <chr>, popular_times <lgl>, site <chr>, phone <chr>, type <chr>,
#> #   logo <chr>, description <chr>, typical_time_spent <lgl>, located_in <lgl>,
#> #   located_google_id <lgl>, category <chr>, subtypes <chr>, posts <lgl>,
#> #   reviews_tags <lgl>, rating <dbl>, reviews <int>, photos_count <int>, …

restaurants$working_hours
#>   Monday Tuesday Wednesday Thursday  Friday Saturday  Sunday
#> 1 4-10PM  Closed    Closed   4-10PM  2-11PM   2-11PM  1-10PM
#> 2 4-10PM  4-10PM    4-10PM   4-10PM 4PM-1AM 12PM-1AM 12-10PM
restaurants$about
#>   Identifies as women-owned Service options.Outdoor seating
#> 1                      TRUE                            TRUE
#> 2                        NA                              NA
#>   Service options.Delivery Service options.Takeout Service options.Dine-in
#> 1                     TRUE                    TRUE                    TRUE
#> 2                       NA                    TRUE                    TRUE
#>   Service options.Curbside pickup Service options.No-contact delivery
#> 1                              NA                                  NA
#> 2                            TRUE                                TRUE
#>   Highlights.Fireplace Highlights.Great cocktails Highlights.Fast service
#> 1                 TRUE                       TRUE                      NA
#> 2                   NA                         NA                    TRUE
#>   Popular for.Lunch Popular for.Dinner Popular for.Solo dining
#> 1              TRUE               TRUE                    TRUE
#> 2              TRUE               TRUE                    TRUE
#>   Accessibility.Wheelchair accessible entrance
#> 1                                         TRUE
#> 2                                         TRUE
#>   Accessibility.Wheelchair accessible restroom
#> 1                                         TRUE
#> 2                                           NA
#>   Accessibility.Wheelchair accessible seating Offerings.Alcohol Offerings.Beer
#> 1                                        TRUE              TRUE           TRUE
#> 2                                          NA              TRUE           TRUE
#>   Offerings.Cocktails Offerings.Coffee Offerings.Comfort food
#> 1                TRUE             TRUE                   TRUE
#> 2                TRUE             TRUE                   TRUE
#>   Offerings.Happy hour drinks Offerings.Happy hour food Offerings.Hard liquor
#> 1                        TRUE                      TRUE                  TRUE
#> 2                        TRUE                        NA                  TRUE
#>   Offerings.Healthy options Offerings.Late-night food
#> 1                      TRUE                      TRUE
#> 2                      TRUE                        NA
#>   Offerings.Private dining room Offerings.Quick bite Offerings.Small plates
#> 1                          TRUE                 TRUE                   TRUE
#> 2                            NA                   NA                   TRUE
#>   Offerings.Vegetarian options Offerings.Wine Dining options.Brunch
#> 1                         TRUE           TRUE                  TRUE
#> 2                           NA           TRUE                  TRUE
#>   Dining options.Lunch Dining options.Dinner Dining options.Catering
#> 1                 TRUE                  TRUE                    TRUE
#> 2                 TRUE                  TRUE                      NA
#>   Dining options.Counter service Dining options.Dessert Dining options.Seating
#> 1                           TRUE                   TRUE                   TRUE
#> 2                             NA                   TRUE                     NA
#>   Amenities.Bar onsite Amenities.Gender-neutral restroom Amenities.Restroom
#> 1                 TRUE                              TRUE               TRUE
#> 2                 TRUE                                NA               TRUE
#>   Amenities.Wi-Fi Atmosphere.Casual Atmosphere.Cozy Atmosphere.Romantic
#> 1            TRUE              TRUE            TRUE                TRUE
#> 2              NA              TRUE            TRUE                  NA
#>   Atmosphere.Trendy Atmosphere.Upscale Crowd.College students
#> 1              TRUE               TRUE                   TRUE
#> 2              TRUE                 NA                     NA
#>   Crowd.Family-friendly Crowd.Groups Crowd.Tourists
#> 1                  TRUE         TRUE           TRUE
#> 2                    NA         TRUE             NA
#>   Planning.Lunch reservations recommended
#> 1                                    TRUE
#> 2                                      NA
#>   Planning.Dinner reservations recommended Planning.Accepts reservations
#> 1                                     TRUE                          TRUE
#> 2                                       NA                          TRUE
#>   Planning.Usually a wait Payments.Credit cards Payments.Debit cards
#> 1                    TRUE                  TRUE                 TRUE
#> 2                      NA                  TRUE                   NA
#>   Payments.NFC mobile payments High chairs Parking.Free street parking
#> 1                         TRUE        TRUE                        TRUE
#> 2                           NA          NA                        TRUE
#>   Parking.Parking Identifies as women-owned
#> 1              NA                      TRUE
#> 2            TRUE                        NA
restaurants$about$`Popular for`
#>   Lunch Dinner Solo dining
#> 1  TRUE   TRUE        TRUE
#> 2  TRUE   TRUE        TRUE
restaurants$reviews_per_score
#>     1   2   3   4    5
#> 1 294 126 269 664 1225
#> 2  10   6   6  20  215
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
#> 1 restaura… Lilia Lilia           ChIJJXC… 0x89c259… 567 Union A… Willia… 567 U…
#> 2 restaura… The … The Commodore   ChIJpwY… 0x89c259… 366 Metropo… Willia… 366 M…
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
#>          Monday                Tuesday              Wednesday      Thursday
#> 1      5-9:30PM               5-9:30PM               5-9:30PM      5-9:30PM
#> 2       4PM-4AM                4PM-4AM                4PM-4AM       4PM-4AM
#> 3       12-10PM                12-10PM                12-10PM       12-10PM
#> 4 8:30AM-3:30PM 8:30AM-3:30PM,5-9:30PM 8:30AM-3:30PM,5-9:30PM 8:30AM-3:30PM
#>                   Friday      Saturday        Sunday
#> 1               4-9:30PM      4-9:30PM      4-9:30PM
#> 2                4PM-4AM      11AM-4AM      11AM-4AM
#> 3                12-11PM     11AM-11PM     11AM-10PM
#> 4 8:30AM-3:30PM,5-9:30PM 8:30AM-3:30PM 8:30AM-3:30PM
multi_restaurants$about
#>   Service options.Outdoor seating Service options.Takeout
#> 1                            TRUE                    TRUE
#> 2                            TRUE                    TRUE
#> 3                            TRUE                    TRUE
#> 4                              NA                    TRUE
#>   Service options.Dine-in Service options.Delivery
#> 1                    TRUE                    FALSE
#> 2                    TRUE                     TRUE
#> 3                    TRUE                     TRUE
#> 4                    TRUE                     TRUE
#>   Service options.Curbside pickup Service options.No-contact delivery
#> 1                              NA                                  NA
#> 2                              NA                                  NA
#> 3                            TRUE                                TRUE
#> 4                            TRUE                                TRUE
#>   Highlights.Great coffee Highlights.Great dessert Highlights.Fast service
#> 1                    TRUE                     TRUE                      NA
#> 2                      NA                       NA                    TRUE
#> 3                      NA                       NA                    TRUE
#> 4                    TRUE                       NA                    TRUE
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
#>   Accessibility.Wheelchair accessible restroom
#> 1                                         TRUE
#> 2                                           NA
#> 3                                         TRUE
#> 4                                         TRUE
#>   Accessibility.Wheelchair accessible seating
#> 1                                        TRUE
#> 2                                        TRUE
#> 3                                        TRUE
#> 4                                        TRUE
#>   Accessibility.Wheelchair accessible parking lot Offerings.Alcohol
#> 1                                           FALSE              TRUE
#> 2                                           FALSE              TRUE
#> 3                                           FALSE              TRUE
#> 4                                           FALSE              TRUE
#>   Offerings.Beer Offerings.Cocktails Offerings.Coffee Offerings.Comfort food
#> 1           TRUE                TRUE             TRUE                   TRUE
#> 2           TRUE                TRUE               NA                   TRUE
#> 3           TRUE                TRUE             TRUE                   TRUE
#> 4           TRUE                  NA             TRUE                   TRUE
#>   Offerings.Hard liquor Offerings.Late-night food Offerings.Small plates
#> 1                  TRUE                      TRUE                   TRUE
#> 2                  TRUE                      TRUE                   TRUE
#> 3                  TRUE                      TRUE                   TRUE
#> 4                    NA                        NA                     NA
#>   Offerings.Vegetarian options Offerings.Wine Offerings.Happy hour drinks
#> 1                         TRUE           TRUE                          NA
#> 2                         TRUE           TRUE                        TRUE
#> 3                         TRUE           TRUE                        TRUE
#> 4                           NA           TRUE                          NA
#>   Offerings.Quick bite Offerings.Happy hour food Offerings.Healthy options
#> 1                   NA                        NA                        NA
#> 2                 TRUE                        NA                        NA
#> 3                 TRUE                      TRUE                      TRUE
#> 4                 TRUE                        NA                        NA
#>   Dining options.Brunch Dining options.Lunch Dining options.Dinner
#> 1                  TRUE                 TRUE                  TRUE
#> 2                  TRUE                 TRUE                  TRUE
#> 3                  TRUE                 TRUE                  TRUE
#> 4                  TRUE                 TRUE                  TRUE
#>   Dining options.Dessert Dining options.Seating Dining options.Breakfast
#> 1                   TRUE                   TRUE                       NA
#> 2                     NA                   TRUE                     TRUE
#> 3                   TRUE                   TRUE                     TRUE
#> 4                   TRUE                   TRUE                     TRUE
#>   Dining options.Catering Dining options.Counter service Amenities.Bar onsite
#> 1                      NA                             NA                 TRUE
#> 2                      NA                             NA                 TRUE
#> 3                    TRUE                             NA                 TRUE
#> 4                    TRUE                           TRUE                 TRUE
#>   Amenities.Restroom Amenities.Wi-Fi Atmosphere.Cozy Atmosphere.Romantic
#> 1               TRUE              NA            TRUE                TRUE
#> 2               TRUE              NA            TRUE                  NA
#> 3               TRUE            TRUE            TRUE                  NA
#> 4               TRUE              NA            TRUE                  NA
#>   Atmosphere.Trending Atmosphere.Trendy Atmosphere.Upscale Atmosphere.Casual
#> 1                TRUE              TRUE               TRUE                NA
#> 2                  NA              TRUE                 NA              TRUE
#> 3                TRUE              TRUE                 NA              TRUE
#> 4                  NA              TRUE                 NA              TRUE
#>   Crowd.Groups Crowd.Tourists Crowd.College students Crowd.Family-friendly
#> 1         TRUE           TRUE                     NA                    NA
#> 2         TRUE           TRUE                   TRUE                    NA
#> 3         TRUE           TRUE                     NA                  TRUE
#> 4           NA             NA                     NA                  TRUE
#>   Crowd.LGBTQ+ friendly Crowd.Transgender safespace
#> 1                    NA                          NA
#> 2                    NA                          NA
#> 3                  TRUE                        TRUE
#> 4                  TRUE                          NA
#>   Planning.Reservations required Planning.Dinner reservations recommended
#> 1                           TRUE                                     TRUE
#> 2                             NA                                       NA
#> 3                             NA                                     TRUE
#> 4                             NA                                       NA
#>   Planning.Accepts reservations Planning.Usually a wait Payments.Credit cards
#> 1                          TRUE                    TRUE                  TRUE
#> 2                         FALSE                      NA                  TRUE
#> 3                          TRUE                      NA                  TRUE
#> 4                          TRUE                      NA                  TRUE
#>   Payments.Debit cards Payments.NFC mobile payments Parking.Free street parking
#> 1                 TRUE                         TRUE                        TRUE
#> 2                 TRUE                         TRUE                        TRUE
#> 3                 TRUE                         TRUE                          NA
#> 4                 TRUE                         TRUE                          NA
#>   Parking.Parking Parking.Paid street parking
#> 1            TRUE                          NA
#> 2            TRUE                        TRUE
#> 3              NA                          NA
#> 4              NA                          NA
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
#>   Great coffee Great dessert Fast service Live music
#> 1         TRUE          TRUE           NA         NA
#> 2           NA            NA         TRUE         NA
#> 3           NA            NA         TRUE       TRUE
#> 4         TRUE            NA         TRUE         NA
multi_restaurants$reviews_per_score
#>     1  2   3   4    5
#> 1 117 62 161 274 1228
#> 2  67 35  57 292  807
#> 3  30 32  67 171  857
#> 4   1  0   4   5  112
```

## Reviews

``` r
library(outscrapr)

# Get your API key from https://outscraper.com/ and set it as the
# environment variable `OUTSCRAPER_API_KEY`
query <- "restaurants, Brooklyn 11203"

restaurant <- google_maps_search(query = query, limit = 1)
restaurant
#> # A tibble: 1 × 58
#>   query     name  name_for_emails place_id google_id full_address borough street
#>   <chr>     <chr> <chr>           <chr>    <chr>     <chr>        <chr>   <chr> 
#> 1 restaura… Irie… Irie Bliss Res… ChIJJ8K… 0x89c25b… 3916 Church… Little… 3916 …
#> # ℹ 50 more variables: postal_code <chr>, area_service <lgl>,
#> #   country_code <chr>, country <chr>, city <chr>, us_state <chr>, state <chr>,
#> #   plus_code <lgl>, latitude <dbl>, longitude <dbl>, h3 <chr>,
#> #   time_zone <chr>, popular_times <lgl>, site <chr>, phone <chr>, type <chr>,
#> #   logo <chr>, description <lgl>, typical_time_spent <lgl>, located_in <lgl>,
#> #   located_google_id <lgl>, category <chr>, subtypes <chr>, posts <lgl>,
#> #   reviews_tags <lgl>, rating <int>, reviews <int>, photos_count <int>, …

reviews <- restaurant[["place_id"]] |> 
  google_maps_reviews(reviews_limit = 2)

reviews
#> # A tibble: 1 × 64
#>   query     name  name_for_emails place_id google_id full_address borough street
#>   <chr>     <chr> <chr>           <chr>    <chr>     <chr>        <chr>   <chr> 
#> 1 ChIJJ8Kt… Irie… Irie Bliss Res… ChIJJ8K… 0x89c25b… 3916 Church… Little… 3916 …
#> # ℹ 56 more variables: postal_code <chr>, area_service <lgl>,
#> #   country_code <chr>, country <chr>, city <chr>, us_state <chr>, state <chr>,
#> #   plus_code <chr>, latitude <dbl>, longitude <dbl>, h3 <chr>,
#> #   time_zone <chr>, popular_times <list>, site <chr>, phone <chr>, type <chr>,
#> #   logo <chr>, description <chr>, typical_time_spent <lgl>, located_in <lgl>,
#> #   located_google_id <lgl>, category <chr>, subtypes <chr>, posts <lgl>,
#> #   reviews_tags <list>, rating <int>, reviews <int>, reviews_data <list>, …
identical(reviews$place_id, restaurant$place_id)
#> [1] TRUE

reviews$reviews
#> [1] 29
reviews$reviews_data
#> [[1]]
#>                               google_id                            review_id
#> 1 0x89c25bb16aadc227:0x69caa35096ca1940  ChZDSUhNMG9nS0VJQ0FnSUNEMzlmQ2JBEAE
#> 2 0x89c25bb16aadc227:0x69caa35096ca1940 ChdDSUhNMG9nS0VJQ0FnSUNKaGVHdnpRRRAB
#>                                                                                                                           review_pagination_id
#> 1 CAESY0NBRVFBUnBFUTJwRlNVRlNTWEJEWjI5QlVEZGZURUZpYW5kZlgxOWZSV2hDYlU1WWQxYzRiRzlxUlc5a1RqbENRVUZCUVVGQlIyZHVPVEpVU1VOalZtOXZaM3BKV1VGRFNVRQ==
#> 2 CAESY0NBRVFBaHBFUTJwRlNVRlNTWEJEWjI5QlVEZGZURUZqV0dKZlgxOWZSV2hCVm5sSVVEa3RXSE5qYkVsMGNpMVhhMEZCUVVGQlIyZHVPVEpVVVVOa2RrSnJRbVZaV1VGRFNVRQ==
#>                                                       author_link
#> 1 https://www.google.com/maps/contrib/106670180153313807225?hl=en
#> 2 https://www.google.com/maps/contrib/116983403507383711315?hl=en
#>     author_title             author_id
#> 1    One Million 106670180153313807225
#> 2 Deseret Segura 116983403507383711315
#>                                                                                                           author_image
#> 1 https://lh3.googleusercontent.com/a-/ALV-UjUEbIgeaSkHQtQjJFfSSjUhkRPIUScSWXP9dqMntGP2vo_tl5MD=s120-c-rp-mo-ba5-br100
#> 2        https://lh3.googleusercontent.com/a/ACg8ocLMbdgUSnB_QqE2V_0ByEuFeb07CfnryBQ6yaVckPBPuatePA=s120-c-rp-mo-br100
#>   author_reviews_count author_ratings_count
#> 1                  455                   37
#> 2                    1                    0
#>                                                                                                                               review_text
#> 1                                                                Omg 8$ . rice very very good\nI like the people who work here. Thx you .
#> 2 The food was absolutely amazing! Well seasoned with fast and loving customer service. Can’t wait to come back! It felt like a warm hug.
#>                                                                                                                                                                                                                                        review_img_urls
#> 1 https://lh5.googleusercontent.com/p/AF1QipMgqZzoIJRtGhiSt6_UvCZIYO8oX1ztPEAu6a2t, https://lh5.googleusercontent.com/p/AF1QipPa1xWDdr6E5Slk4ULD-vaTacFx2Qtie01QbKm6, https://lh5.googleusercontent.com/p/AF1QipPygiFWjSjuUyEdRjz9JpOBBh3jOM7V_-9fpCzq
#> 2                                                                                   https://lh5.googleusercontent.com/p/AF1QipO5G-PrtfDk2RbFBTBIVWmZUJmsXgv1qwRcH0Qk, https://lh5.googleusercontent.com/p/AF1QipMuzn4ekeijXa5u_8LRDTPtyeaBsRcRI5WScpJX
#>                                                                                      review_img_url
#> 1 https://lh5.googleusercontent.com/p/AF1QipMgqZzoIJRtGhiSt6_UvCZIYO8oX1ztPEAu6a2t=w150-h150-k-no-p
#> 2 https://lh5.googleusercontent.com/p/AF1QipO5G-PrtfDk2RbFBTBIVWmZUJmsXgv1qwRcH0Qk=w150-h150-k-no-p
#>   review_questions.Food review_questions.Service review_questions.Atmosphere
#> 1                     5                        5                           4
#> 2                     5                        5                           5
#>   review_questions.Meal type review_questions.Price per person
#> 1                       <NA>                              <NA>
#> 2                     Dinner                            $10–20
#>                                                                                                                           review_photo_ids
#> 1 AF1QipMgqZzoIJRtGhiSt6_UvCZIYO8oX1ztPEAu6a2t, AF1QipPa1xWDdr6E5Slk4ULD-vaTacFx2Qtie01QbKm6, AF1QipPygiFWjSjuUyEdRjz9JpOBBh3jOM7V_-9fpCzq
#> 2                                               AF1QipO5G-PrtfDk2RbFBTBIVWmZUJmsXgv1qwRcH0Qk, AF1QipMuzn4ekeijXa5u_8LRDTPtyeaBsRcRI5WScpJX
#>   owner_answer owner_answer_timestamp owner_answer_timestamp_datetime_utc
#> 1           NA                     NA                                  NA
#> 2           NA                     NA                                  NA
#>                                                                                                                                                                                       review_link
#> 1   https://www.google.com/maps/reviews/data=!4m8!14m7!1m6!2m5!1sChZDSUhNMG9nS0VJQ0FnSUNEMzlmQ2JBEAE!2m1!1s0x0:0x69caa35096ca1940!3m1!1s2@1:CIHM0ogKEICAgICD39fCbA%7CCgwIkpG3sAYQ4LPprwI%7C?hl=en
#> 2 https://www.google.com/maps/reviews/data=!4m8!14m7!1m6!2m5!1sChdDSUhNMG9nS0VJQ0FnSUNKaGVHdnpRRRAB!2m1!1s0x0:0x69caa35096ca1940!3m1!1s2@1:CIHM0ogKEICAgICJheGvzQE%7CCgwI28n-pAYQoPOJwQI%7C?hl=en
#>   review_rating review_timestamp review_datetime_utc review_likes
#> 1             5       1712179346 04/03/2024 21:22:26            0
#> 2             5       1688184027 07/01/2023 04:00:27            0
#>            reviews_id
#> 1 7623084885800524096
#> 2 7623084885800524096
reviews$reviews_data[[1]]$review_text
#> [1] "Omg 8$ . rice very very good\nI like the people who work here. Thx you ."                                                               
#> [2] "The food was absolutely amazing! Well seasoned with fast and loving customer service. Can’t wait to come back! It felt like a warm hug."

reviews$reviews_data[[1]]$review_questions
#>   Food Service Atmosphere Meal type Price per person
#> 1    5       5          4      <NA>             <NA>
#> 2    5       5          5    Dinner           $10–20
reviews$reviews_data[[1]]$owner_answer
#> [1] NA NA
```

## Code of Conduct

Please note that the outscrapr project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
