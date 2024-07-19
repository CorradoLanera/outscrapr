test_that("google_maps_reviews errors", {
  # expectations
  google_maps_reviews() |>
    expect_error("\"query\" is missing")

  google_maps_reviews("pizzeria, New York", api_key = "") |>
    expect_error("401 Unauthorized")
})


test_that("google_maps_reviews works", {
  skip_on_cran()
  skip_on_ci()
  skip_on_covr()

  # setup
  place <- google_maps_search("coffee, New York", limit = 2) |>
    dplyr::pull("place_id") |>
    purrr::pluck(1)

  # execution
  res <- google_maps_reviews(
    place,
    reviews_limit = 2,
    sort = "lowest_rating"
  )

  # expectations
  res |> expect_tibble(nrows = 1, null.ok = FALSE)
  res$reviews_data[[1]] |> expect_data_frame(nrows = 2, null.ok = FALSE)
})
