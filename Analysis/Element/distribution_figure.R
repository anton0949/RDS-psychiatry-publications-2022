#' Generates bar chart for showing JIF distribution in publications
#'
#' @param table_path path to generated table containing distribution data 
#' @param dataset    reference dataset
#' @param file       file name. NB.: must contain file type e.g. .jpeg
#' @param color      bar color (hex)
#'
#' @return void
distribution_figure <- function(
    table_path,
    dataset,
    file,
    color
) {
    data <-
        readr::read_csv(
            table_path,
            show_col_types = FALSE
        ) |>
        dplyr::select(cat, `2021`, `2022`) |>
        dplyr::filter(cat != "Sum") |>
        tidyr::pivot_longer(
            cols = `2021`:`2022`,
            names_to = "year",
            values_to = "N"
        )

    multiple_bar_chart(
        name    = file,
        data    = data,
        x       = data$cat,
        y       = data$N,
        fill    = data$year,
        scales   = c(
            "2021" = paste0(color, "50"),
            "2022" = color
        ),
        min     = 0,
        max     = (ceiling(max(data$N) / 2) * 2) + 2,
        step    = 2,
        x_label = "Journal Impact Factor",
        y_label = "Number of publications",
        fill_label = ""
    )
}
