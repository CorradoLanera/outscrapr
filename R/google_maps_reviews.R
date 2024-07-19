#' Google Maps Reviews
#'
#' Returns Google Maps reviews from places when using search queries
#' (e.g., `"restaurants, Manhattan, NY, USA"`) or from a single place
#' when using Google IDs or names (e.g., `"NoMad Restaurant, NY, USA"`,
#' `"0x886916e8bc273979:0x5141fcb11460b226"`). In addition to the
#' reviews, it returns places information.
#'
#'
#' @param query (chr) the query you want to search. You can use anything
#'   that you would use on a regular Google Maps site. Additionally, you
#'   can use google_id (feature_id), place_id, or CID.
#' @param reviews_limit (int, default = 10) The parameter specifies the
#'   limit of reviews to get from one place (0 = unlimited).
#' @param reviews_query (chr) The parameter specifies the query to
#'   search among the reviews (e.g. `wow`, `amazing | great`).
#' @param limit (int, default = 10) The parameter specifies the limit of
#'   organizations to take from one query search.
#' @param sort (chr, default = "most_relevant") one of the sorting
#'   types: "most_relevant", "newest", "highest_rating",
#'   "lowest_rating".
#' @param last_pagination_id (chr) the `review_pagination_id` of the
#'   last item. It's commonly used in pagination.
#' @param start (int) the start timestamp value for reviews (newest
#'   review). The current timestamp is used when the value is not
#'   provided. Using the `start` parameter overwrites the `sort`
#'   parameter to `newest`. Therefore, the latest reviews will be at the
#'   beginning.
#' @param cutoff (int) the oldest timestamp value for reviews (oldest
#'   review). Using the `cutoff` parameter overwrites `sort` parameter
#'   to `newest`. Therefore, the latest reviews will be at the
#'   beginning.
#' @param cutoff_rating (int) the maximum for `lowest_rating` sorting or
#'   the minimum for `highest_rating` sorting rating for reviews. Using
#'   the `cutoff_rating` requires sorting to be set to `lowest_rating`
#'   or `highest_rating`.
#' @param ignore_empty (lgl, default = TRUE) whether to ignore reviews
#'   without text or not.
#' @param language (chr, default = "en") the language to use for
#'   website.
#' @param region (chr, default = NULL) the country to use for website.
#'   It's recommended to use it for a better search experience.
#' @param fields (chr) which fields you want to include with each item
#'   returned in the response. By default, it returns all fields. Use
#'   `&fields=query,name` to return only the specific ones.
#' @param async (lgl, default = FALSE) The parameter defines the way you
#'   want to submit your task to Outscraper. It can be set to `FALSE` to
#'   open an HTTP connection and keep it open until you got your
#'   results, or `TRUE` to just submit your requests to Outscraper and
#'   retrieve them later (usually within 1-3 minutes) with the Request
#'   Results endpoint. Each response is available for 2 hours after a
#'   request has been completed.
#' @param api_key (chr, default = Sys.getenv("OUTSCRAPER_API_KEY")) Your
#'   API key. You can get it by registering on
#'   [Outscraper](https://outscraper.com/).
#' @param ui (lgl, default = FALSE) whether a task will be executed as a
#'   UI task. This is commonly used when you want to create a regular
#'   platform task with API. Using this parameter overwrites the async
#'   parameter to true.
#' @param webhook (chr, default = NULL) defines the URL address
#'   (callback) to which Outscraper will create a 57POST request with a
#'   JSON body once a task/request is finished. Using this parameter
#'   overwrites the webhook from integrations.
#'
#' @details
#'
#' ## Queries
#' The example of valid queries:
#' - Real estate agency, Rome, Italy
#' - The NoMad Restaurant, NY, USA
#' - restaurants, Brooklyn 11203
#' - 0x886916e8bc273979:0x5141fcb11460b226
#' - ChIJrZhup4lZwokRUr_5sLoFlDw
#' - etc.
#'
#' It supports batching by sending arrays with up to 250 queries (e.g.,
#' query=text1&query=text2&query=text3). It allows multiple queries to
#' be sent in one request and save on network latency time. You might
#' want to check out the web application to play with locations and
#' categories that we would suggest.
#'
#' ## Async
#' A good practice is to send async requests and start checking
#' the results after the estimated execution time. Check out this Python
#' implementation as an example.
#'
#' As most of the requests take some time to be executed the `async =
#' TRUE` option is preferred to avoid HTTP requests timeouts.
#'
#' ## Optimization
#' In case no reviews were found by your search criteria, your search
#' request will consume the usage of one review.
#'
#' This endpoint is optimized for fast responses and can be used as a
#' real-time API. Set the reviewsLimit parameter to 10 to achieve the
#' maximum response speed.
#'
#' @return a [tibble][tibble::tibble-package] of reviews from Google
#'   Maps based on a given search query (or many queries).
#' @export
#'
#' @examples
#' if (FALSE) {
#'   # single
#'   google_maps_search("pizzeria, New York", limit = 1)[["place_id"]] |>
#'     google_maps_reviews(reviews_limit = 2)
#'
#' }
google_maps_reviews <- function(
  query,
  reviews_limit = 10,
  reviews_query = NULL,
  limit = 1,
  sort = c("most_relevant", "newest", "highest_rating", "lowest_rating"),
  last_pagination_id = NULL,
  start = NULL,
  cutoff = NULL,
  cutoff_rating = NULL,
  ignore_empty = TRUE,
  language = "en",
  region = NULL,
  fields = NULL,
  async = FALSE,
  ui = FALSE,
  webhook = NULL,
  api_key = Sys.getenv("OUTSCRAPER_API_KEY")
) {
  checkmate::assert_character(query)
  reviews_limit |>
    checkmate::assert_integerish(lower = 0, len = 1)
  checkmate::assert_string(reviews_query, null.ok = TRUE)
  limit |>
    checkmate::assert_integerish(upper = 500, null.ok = TRUE, len = 1)
  sort <- match.arg(sort)
  checkmate::assert_string(last_pagination_id, null.ok = TRUE)
  checkmate::assert_integerish(start, null.ok = TRUE)
  checkmate::assert_integerish(cutoff, null.ok = TRUE)
  checkmate::assert_integerish(cutoff_rating, null.ok = TRUE)
  checkmate::assert_logical(ignore_empty)
  checkmate::assert_logical(async)
  checkmate::assert_logical(ui)
  checkmate::assert_character(webhook, null.ok = TRUE)
  checkmate::assert_character(api_key)

  languages <- c(
    "en", "de", "es", "es-419", "fr", "hr", "it", "nl", "pl", "pt-BR",
    "pt-PT", "vi", "tr", "ru", "ar", "th", "ko", "zh-CN", "zh-TW", "ja",
    "ach", "af", "ak", "ig", "az", "ban", "ceb", "xx-bork", "bs", "br",
    "ca", "cs", "sn", "co", "cy", "da", "yo", "et", "xx-elmer", "eo",
    "eu", "ee", "tl", "fil", "fo", "fy", "gaa", "ga", "gd", "gl", "gn",
    "xx-hacker", "ht", "ha", "haw", "bem", "rn", "id", "ia", "xh", "zu",
    "is", "jw", "rw", "sw", "tlh", "kg", "mfe", "kri", "la", "lv", "to",
    "lt", "ln", "loz", "lua", "lg", "hu", "mg", "mt", "mi", "ms", "pcm",
    "no", "nso", "ny", "nn", "uz", "oc", "om", "xx-pirate", "ro", "rm",
    "qu", "nyn", "crs", "sq", "sk", "sl", "so", "st", "sr-ME",
    "sr-Latn", "su", "fi", "sv", "tn", "tum", "tk", "tw", "wo", "el",
    "be", "bg", "ky", "kk", "mk", "mn", "sr", "tt", "tg", "uk", "ka",
    "hy", "yi", "iw", "ug", "ur", "ps", "sd", "fa", "ckb", "ti", "am",
    "ne", "mr", "hi", "bn", "pa", "gu", "or", "ta", "te", "kn", "ml",
    "si", "lo", "my", "km", "chr"
  )

  regions <- c(
    "AF", "AL", "DZ", "AS", "AD", "AO", "AI", "AG", "AR", "AM", "AU",
    "AT", "AZ", "BS", "BH", "BD", "BY", "BE", "BZ", "BJ", "BT", "BO",
    "BA", "BW", "BR", "VG", "BN", "BG", "BF", "BI", "KH", "CM", "CA",
    "CV", "CF", "TD", "CL", "CN", "CO", "CG", "CD", "CK", "CR", "CI",
    "HR", "CU", "CY", "CZ", "DK", "DJ", "DM", "DO", "EC", "EG", "SV",
    "EE", "ET", "FJ", "FI", "FR", "GA", "GM", "GE", "DE", "GH", "GI",
    "GR", "GL", "GT", "GG", "GY", "HT", "HN", "HK", "HU", "IS", "IN",
    "ID", "IQ", "IE", "IM", "IL", "IT", "JM", "JP", "JE", "JO", "KZ",
    "KE", "KI", "KW", "KG", "LA", "LV", "LB", "LS", "LY", "LI", "LT",
    "LU", "MG", "MW", "MY", "MV", "ML", "MT", "MU", "MX", "FM", "MD",
    "MN", "ME", "MS", "MA", "MQ", "MZ", "MM", "NA", "NR", "NP", "NL",
    "NZ", "NI", "NE", "NG", "NU", "MK", "NO", "OM", "PK", "PS", "PA",
    "PG", "PY", "PE", "PH", "PN", "PL", "PT", "PR", "QA", "RO", "RU",
    "RW", "WS", "SM", "ST", "SA", "SN", "RS", "SC", "SL", "SG", "SK",
    "SI", "SB", "SO", "ZA", "KR", "ES", "LK", "SH", "VC", "SR", "SE",
    "CH", "TW", "TJ", "TZ", "TH", "TL", "TG", "TO", "TT", "TN", "TR",
    "TM", "VI", "UG", "UA", "AE", "GB", "US", "UY", "UZ", "VU", "VE",
    "VN", "ZM", "ZW"
  )

  checkmate::assert_choice(language, languages)
  checkmate::assert_choice(region, regions, null.ok = TRUE)

  response <- httr::GET(
    "https://api.app.outscraper.com/maps/reviews-v3",
    httr::add_headers(
      "X-API-KEY" = api_key
    ),
    httr::content_type_json(),
    encode = "json",
    query = list(
      query = as.list(query),
      reviewsLimit = reviews_limit,
      reviewsQuery = reviews_query,
      limit = limit,
      sort = sort,
      lastPaginationId = last_pagination_id,
      start = start,
      cutoff = cutoff,
      cutoffRating = cutoff_rating,
      ignoreEmpty = ignore_empty,
      language = language,
      region = region,
      fields = fields,
      async = async,
      ui = ui,
      webhook = webhook
    )
  )

  parsed <- response |>
    httr::content(as = "text", encoding = "UTF-8") |>
    jsonlite::fromJSON()

  if (httr::http_error(response)) {
    err <- parsed[["errorMessage"]]
    err <- if (is.character(err)) err else err[["message"]]
    stringr::str_c(
      "API request failed [",
      httr::status_code(response),
      "]:\n\n",
      err
    ) |>
      usethis::ui_stop()
  }

  get_content(parsed)
}
