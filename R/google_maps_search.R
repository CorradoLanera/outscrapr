#' Google Maps Search
#'
#' Search for places on Google Maps based on a given query (or many
#' queries).
#'
#'
#' @param query (chr) the query you want to search. You
#'   can use anything that you would use on a regular Google Maps site.
#'   Additionally, you can use google_id (feature_id), place_id, or CID.
#' @param limit (int, default = 10) The parameter specifies the limit
#'   of organizations to take from one query search.
#' @param drop_duplicates (lgl, default = FALSE) The parameter specifies
#'   whether the bot will drop the same organizations from different
#'   queries. It makes sense when you use batching and send multiple
#'   queries inside one request.
#' @param coordinates (chr) The parameter defines the coordinates of the
#'   location where you want your query to be applied. It has to be
#'   constructed in the next sequence: `paste0(latitude, ", ",
#'   longitude)`, e.g. `"(41.3954381,2.1628662)"`. Often, you can find
#'   this value while visiting [Google
#'   Maps](https://www.google.com/maps/search/restaurants,+Manhattan,+New+York,+NY,+USA/@40.7510123,-73.9803871,13.68z).
#' @param skipPlaces (int) Skip first N places, where N should be
#'   multiple to 20 (e.g. 0, 20, 40). It's commonly used in pagination.
#' @param language (chr, default = "en") the language to use for
#'   website.
#' @param region (chr, default = NULL) the country to use for website.
#'   It's recommended to use it for a better search experience.
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
#' ## Limit
#' There are no more than 500 places per one query search on
#' Google Maps. For densely populated areas you might want to split your
#' query into subqueries in order to get all the places inside. (e.g.,
#' `c("restaurants, Brooklyn 11211", "restaurants, Brooklyn 11215")`).
#'
#' ## Drop duplicates
#' When `TRUE` the bot combines results from each
#' query inside one big array (`{'data': [...]}` instead of `{'data':
#' [[...], [...], [...]]}`). If the amount of ignored rows are less than
#' 5,000% of what was actually extracted, you won't be billed for
#' ignored records.
#'
#' ## Async
#' A good practice is to send async requests and start checking
#' the results after the estimated execution time. Check out this Python
#' implementation as an example.
#'
#' As most of the requests take some time to be executed the `async =
#' TRUE` option is preferred to avoid HTTP requests timeouts.
#'
#' ## Results
#' The results from searches are the same as you would see by
#' visiting a regular Google Maps site. However, in most cases, it's
#' important to use locations inside queries (e.g., bars, NY, USA) as
#' the IP addresses of Outscraper's servers might be located in
#' different countries.
#'
#' ## Optimization
#' In case no places were found by your search criteria,
#' your search request will consume the usage of one place.
#'
#' This endpoint is optimized for fast responses and can be used as a
#' real-time API. Set the limit parameter to 10 to achieve the maximum
#' response speed.
#'
#' @return A list with places from Google Maps based on a given search
#'   query (or many queries).
#' @export
#'
#' @examples
#' if (FALSE) {
#'   # single
#'   google_maps_search("pizzeria, New York", limit = 2)
#'
#'   # multiple
#'   google_maps_search(
#'     c("pizzeria, New York", "pizzeria, Chicago"),
#'     limit = 2  # each query will return 2 places max
#'   )
#' }
google_maps_search <- function(
    query,
    limit = 10,
    drop_duplicates = FALSE,
    coordinates = NULL,
    skipPlaces = 0,
    language = "en",
    region = NULL,
    async = FALSE,
    api_key = Sys.getenv("OUTSCRAPER_API_KEY")

) {
  checkmate::assert_character(query)
  limit |>
    checkmate::assert_integerish(upper = 500, null.ok = TRUE, len = 1)
  checkmate::assert_logical(drop_duplicates)
  checkmate::assert_character(coordinates, null.ok = TRUE)
    skipPlaces |>
    checkmate::assert_integerish(lower = 0, len = 1, null.ok = TRUE)
  checkmate::assert_logical(async)
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

  response <- httr::POST(
    "https://api.app.outscraper.com/maps/search-v3",
    httr::add_headers(
      "X-API-KEY" = api_key
    ),
    httr::content_type_json(),
    encode = "json",
    body = list(
      query = as.list(query),
      limit = limit,
      dropDuplicates = drop_duplicates,
      coordinates = coordinates,
      skipPlaces = skipPlaces,
      language = language,
      region = region,
      async = async
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

#' Get Outscraper content
#'
#' @param parsed (list) the parsed JSON response from Outscraper
#'
#' @return a [tibble][tibble::tibble-package]
get_content <- function(parsed) {
  parsed[["data"]] |>
    purrr::list_rbind() |>
    tibble::as_tibble()
}
