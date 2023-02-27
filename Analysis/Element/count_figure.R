#' Generates bar chart for showing development in publication count
#'
#' @param historical_path    historical datafiles directory
#' @param historical_postfix postfix on historical datafiles e.g. _first_senior
#' @param dataset            reference dataset
#' @param file               file name. NB.: must contain file type e.g. .jpeg
#' @param color              bar color (hex)
#'
#' @return void
count_figure <- function(
    historical_path,
    historical_postfix,
    dataset,
    file,
    color
) {
    data <- readr::read_csv(
        here::here(historical_path, paste0("n", historical_postfix, ".csv")),
        show_col_types = FALSE
    )

    data <- data |> tibble::add_row(
        year = 2022,
        N    = as.numeric(dataset |> dplyr::count())
    )

    step <- (round((max(data$N) / 5) / 5) * 5)
    maxdata <- (ceiling(max(data$N) / step) * step) + step

    single_bar_chart(
        name = file,
        data = data,
        x = data$year,
        y = data$N,
        color = color,
        min = 0,
        max = maxdata,
        step = step,
        x_label = "",
        y_label = "Number of publications"
    )
}
