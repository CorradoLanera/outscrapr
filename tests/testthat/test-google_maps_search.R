test_that("google_maps_search works", {
  skip_on_cran()
  skip_on_ci()
  skip_on_covr()

  # setup

  # execution
  res <- google_maps_search(
    "pizzeria, New York",
    limit = 2
  )

  res_multi <- google_maps_search(
    c("pizzeria, New York", "pizzeria, Chicago"),
    limit = 2
  )

  # expectations
  google_maps_search() |>
    expect_error("\"query\" is missing")

  google_maps_search("pizzeria, New York", api_key = "") |>
    expect_error("401 Unauthorized")

  res |> expect_tibble(nrows = 2, null.ok = FALSE)
  res_multi |> expect_tibble(nrows = 4, null.ok = FALSE)
})
