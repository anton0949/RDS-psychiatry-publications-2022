#' Generates bar chart for showing development in publication JIF median
#'
#' @param historical_path    historical datafiles directory
#' @param historical_postfix postfix on historical datafiles e.g. _first_senior
#' @param dataset            reference dataset
#' @param file               file name. NB.: must contain file type e.g. .jpeg
#' @param color              bar color (hex)
#'
#' @return void
median_figure <- function(
    historical_path,
    historical_postfix,
    dataset,
    file,
    color
) {
    data <- readr::read_csv(
        here::here(historical_path, paste0("median", historical_postfix, ".csv")),
        show_col_types = FALSE
    )

    data <- data |> tibble::add_row(
        year = 2022,
        median = round(median(dataset$jif2021), 3)
    )

    single_bar_chart(
        name = file,
        data = data,
        x = data$year,
        y = data$median,
        color = color,
        min = 0,
        max = ceiling(max(data$median)) + 1,
        step = 1,
        x_label = "",
        y_label = "Journal Impact Factor"
    )
}
