
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
restaurants |> 
  tibble::as_tibble()
#> # A tibble: 2 × 58
#>   query     name  name_for_emails place_id google_id full_address borough street
#>   <chr>     <chr> <chr>           <chr>    <chr>     <chr>        <chr>   <chr> 
#> 1 restaura… LILL… Lilli Restaura… ChIJU4x… 0x89c25d… 1344 Utica … East F… 1344 …
#> 2 restaura… Irie… Irie Bliss Res… ChIJJ8K… 0x89c25b… 3916 Church… Little… 3916 …
#> # ℹ 50 more variables: postal_code <chr>, area_service <lgl>,
#> #   country_code <chr>, country <chr>, city <chr>, us_state <chr>, state <chr>,
#> #   plus_code <lgl>, latitude <dbl>, longitude <dbl>, h3 <chr>,
#> #   time_zone <chr>, popular_times <lgl>, site <chr>, phone <chr>, type <chr>,
#> #   logo <chr>, description <lgl>, typical_time_spent <lgl>, located_in <lgl>,
#> #   located_google_id <lgl>, category <chr>, subtypes <chr>, posts <lgl>,
#> #   reviews_tags <lgl>, rating <dbl>, reviews <int>, photos_count <int>, …

restaurants$working_hours
#>   Monday   Tuesday Wednesday  Thursday   Friday  Saturday   Sunday
#> 1 4-10PM    4-10PM    4-10PM    4-10PM  4PM-1AM  12PM-1AM  12-10PM
#> 2 Closed 10AM-10PM 10AM-10PM 10AM-10PM 8AM-10PM 10AM-10PM 10AM-6PM
restaurants$about |> 
  tibble::as_tibble()
#> # A tibble: 2 × 12
#>   `Service options`$`Curbside pickup` Highlights$Fast serv…¹ `Popular for`$Lunch
#>   <lgl>                               <lgl>                  <lgl>              
#> 1 TRUE                                TRUE                   TRUE               
#> 2 TRUE                                NA                     TRUE               
#> # ℹ abbreviated name: ¹​Highlights$`Fast service`
#> # ℹ 16 more variables: `Service options`$`No-contact delivery` <lgl>,
#> #   $Takeout <lgl>, $`Dine-in` <lgl>, $Delivery <lgl>,
#> #   `Popular for`$Dinner <lgl>, $`Solo dining` <lgl>, $Breakfast <lgl>,
#> #   Accessibility <df[,1]>, Offerings <df[,11]>, `Dining options` <df[,8]>,
#> #   Amenities <df[,2]>, Atmosphere <df[,3]>, Crowd <df[,1]>, Planning <df[,1]>,
#> #   Payments <df[,3]>, Parking <df[,2]>

restaurants$about$`Popular for`
#>   Lunch Dinner Solo dining Breakfast
#> 1  TRUE   TRUE        TRUE        NA
#> 2  TRUE   TRUE        TRUE      TRUE
restaurants$reviews_per_score
#>    1 2 3  4   5
#> 1 10 6 6 20 215
#> 2  0 0 0  1  28
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
multi_restaurants |> 
  tibble::as_tibble()
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
multi_restaurants$about |> 
  tibble::as_tibble()
#> # A tibble: 4 × 15
#>   Service options$Outdoor…¹ $Delivery Highlights$Fast serv…² `Popular for`$Lunch
#>   <lgl>                     <lgl>     <lgl>                  <lgl>              
#> 1 TRUE                      TRUE      TRUE                   TRUE               
#> 2 TRUE                      FALSE     NA                     TRUE               
#> 3 TRUE                      TRUE      TRUE                   TRUE               
#> 4 NA                        TRUE      TRUE                   TRUE               
#> # ℹ abbreviated names: ¹​`Service options`$`Outdoor seating`,
#> #   ²​Highlights$`Fast service`
#> # ℹ 22 more variables: `Service options`$Takeout <lgl>, $`Dine-in` <lgl>,
#> #   $`Curbside pickup` <lgl>, $`No-contact delivery` <lgl>,
#> #   Highlights$`Great coffee` <lgl>, $`Great dessert` <lgl>,
#> #   $`Live music` <lgl>, `Popular for`$Dinner <lgl>, $`Solo dining` <lgl>,
#> #   $Breakfast <lgl>, Accessibility <df[,4]>, Offerings <df[,14]>, …

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

## Reviews

``` r
library(outscrapr)

# Get your API key from https://outscraper.com/ and set it as the
# environment variable `OUTSCRAPER_API_KEY`
query <- "restaurants, Brooklyn 11203"

restaurant <- google_maps_search(query = query, limit = 1)
restaurant |> 
  tibble::as_tibble()
#> # A tibble: 1 × 58
#>   query     name  name_for_emails place_id google_id full_address borough street
#>   <chr>     <chr> <chr>           <chr>    <chr>     <chr>        <chr>   <chr> 
#> 1 restaura… LILL… Lilli Restaura… ChIJU4x… 0x89c25d… 1344 Utica … East F… 1344 …
#> # ℹ 50 more variables: postal_code <chr>, area_service <lgl>,
#> #   country_code <chr>, country <chr>, city <chr>, us_state <chr>, state <chr>,
#> #   plus_code <lgl>, latitude <dbl>, longitude <dbl>, h3 <chr>,
#> #   time_zone <chr>, popular_times <lgl>, site <chr>, phone <chr>, type <chr>,
#> #   logo <chr>, description <lgl>, typical_time_spent <lgl>, located_in <lgl>,
#> #   located_google_id <lgl>, category <chr>, subtypes <chr>, posts <lgl>,
#> #   reviews_tags <lgl>, rating <dbl>, reviews <int>, photos_count <int>, …

reviews <- restaurant[["place_id"]] |> 
  google_maps_reviews(reviews_limit = 2)

reviews |> 
  tibble::as_tibble()
#> # A tibble: 1 × 64
#>   query     name  name_for_emails place_id google_id full_address borough street
#>   <chr>     <chr> <chr>           <chr>    <chr>     <chr>        <chr>   <chr> 
#> 1 ChIJU4xg… LILL… Lilli Restaura… ChIJU4x… 0x89c25d… 1344 Utica … East F… 1344 …
#> # ℹ 56 more variables: postal_code <chr>, area_service <lgl>,
#> #   country_code <chr>, country <chr>, city <chr>, us_state <chr>, state <chr>,
#> #   plus_code <chr>, latitude <dbl>, longitude <dbl>, h3 <chr>,
#> #   time_zone <chr>, popular_times <list>, site <chr>, phone <chr>, type <chr>,
#> #   logo <chr>, description <lgl>, typical_time_spent <chr>, located_in <lgl>,
#> #   located_google_id <lgl>, category <chr>, subtypes <chr>, posts <lgl>,
#> #   reviews_tags <list>, rating <dbl>, reviews <int>, reviews_data <list>, …

identical(reviews$place_id, restaurant$place_id)
#> [1] TRUE

reviews$reviews |> 
  tibble::as_tibble()
#> # A tibble: 1 × 1
#>   value
#>   <int>
#> 1   257

reviews$reviews_data[[1]] |> 
  tibble::as_tibble()
#> # A tibble: 2 × 23
#>   google_id    review_id review_pagination_id author_link author_title author_id
#>   <chr>        <chr>     <chr>                <chr>       <chr>        <chr>    
#> 1 0x89c25db3d… ChdDSUhN… CAESY0NBRVFBUnBFUTJ… https://ww… samuel lyght 11508292…
#> 2 0x89c25db3d… ChZDSUhN… CAESY0NBRVFBaHBFUTJ… https://ww… Najuma Burke 10067722…
#> # ℹ 17 more variables: author_image <chr>, author_reviews_count <int>,
#> #   author_ratings_count <int>, review_text <chr>, review_img_urls <list>,
#> #   review_img_url <chr>, review_questions <df[,6]>, review_photo_ids <list>,
#> #   owner_answer <chr>, owner_answer_timestamp <int>,
#> #   owner_answer_timestamp_datetime_utc <chr>, review_link <chr>,
#> #   review_rating <int>, review_timestamp <int>, review_datetime_utc <chr>,
#> #   review_likes <int>, reviews_id <chr>

reviews$reviews_data[[1]]$review_text
#> [1] "The appetizers were delicious, the ambiance was pleasant, and the drinks were excellent. However, it was a little on the expensive side. The new waitress was outstanding. Despite her slow service and lack of menu knowledge, I ordered the snapper, which was well-seasoned but not particularly tasty. The fried rice was slightly salty."                                                                                                                                                              
#> [2] "From the time we entered things were pleasant. We were met with a smile and greetings. The staff were accommodating and work well together. The drinks made by Simone were 10/10. They were smooth and the flavors well balanced. Our server Mimi was amazing and attentive and and overall sweetheart. I’ll be requesting her again. Big up to the chef because the food was finger licking good. Chef Omar knows what he is doing with his flavors… 10/10. We had no complaints we. We will be on repeat."

reviews$reviews_data[[1]]$review_questions
#>   Service Meal type Price per person Food Atmosphere Recommended dishes
#> 1       3    Brunch          $50–100    4          4                 NA
#> 2       5    Brunch          $50–100    5          5                 NA
reviews$reviews_data[[1]]$owner_answer
#> [1] "Hi Samuel \n\nThank you so much for the great feedback! Guest experience is very important to us and we strive to make this restaurant a place that everyone can enjoy! We are happy you had a good time and we hope to see you again. \n\n"
#> [2] NA
```

## Code of Conduct

Please note that the outscrapr project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
