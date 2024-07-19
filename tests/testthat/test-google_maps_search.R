test_that("google_maps_search errors", {
  # expectations
  google_maps_search() |>
    expect_error("\"query\" is missing")

  google_maps_search("pizzeria, New York", api_key = "") |>
    expect_error("401 Unauthorized")
})


test_that("google_maps_search works", {
  skip_on_cran()
  skip_on_ci()
  skip_on_covr()

  # execution
  res <- google_maps_search(
    "coffee, New York",
    limit = 2
  )

  res_multi <- google_maps_search(
    c("coffee, New York", "resturant, Chicago"),
    limit = 1
  )

  # expectations
  res |> expect_tibble(nrows = 2, null.ok = FALSE)
  res_multi |> expect_tibble(nrows = 2, null.ok = FALSE)
})
