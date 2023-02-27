#' Generates and saves table in csv format for e.g. table 1.
#'
#' @param historical_path    historical datafiles directory
#' @param historical_postfix postfix on historical datafiles e.g. _first_senior
#' @param dataset            reference dataset
#' @param file               file name. NB.: must contain file type e.g. .jpeg
#' @param color              bar color (hex)
#'
#' @return void
overview_table <- function(
    historical_path,
    historical_postfix,
    dataset,
    file,
    color
) {
    data <-
        readr::read_csv(
            here::here(
                historical_path,
                paste0("n", historical_postfix, ".csv")
            ),
            show_col_types = FALSE
        ) |>
        dplyr::left_join(
            readr::read_csv(
                here::here(
                    historical_path,
                    paste0("sum", historical_postfix, ".csv")
                ),
                show_col_types = FALSE
            )
        ) |>
        dplyr::left_join(
            readr::read_csv(
                here::here(
                    historical_path,
                    paste0("mean", historical_postfix, ".csv")
                ),
                show_col_types = FALSE
            )
        ) |>
        dplyr::left_join(
            readr::read_csv(
                here::here(
                    historical_path,
                    paste0("median", historical_postfix, ".csv")
                ),
                show_col_types = FALSE
            )
        ) |>
        tibble::add_row(
            year   = 2022,
            N      = as.numeric(dataset |> dplyr::count()),
            sum    = round(sum(dataset$jif2021), 3),
            mean   = round(mean(dataset$jif2021), 3),
            median = round(median(dataset$jif2021), 3)
        )

    write.csv(
        data,
        file = file,
        row.names = FALSE,
        fileEncoding = "UTF-8"
    )
}
