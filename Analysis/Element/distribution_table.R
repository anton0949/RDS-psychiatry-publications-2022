#' Generates and saves table in csv format for e.g. table 3.
#'
#' @param historical_path    historical datafiles directory
#' @param historical_postfix postfix on historical datafiles e.g. _first_senior
#' @param dataset            reference dataset
#' @param file               file name. NB.: must contain file type e.g. .jpeg
#' @param color              bar color (hex)
#'
#' @return void
distribution_table <- function(
    historical_path,
    historical_postfix,
    dataset,
    file,
    color
) {
    data <- readr::read_csv(
        here::here(
            historical_path,
            paste0("category_n", historical_postfix, ".csv")
        ),
        show_col_types = FALSE
    )

    data <- data |> dplyr::left_join(
        tibble::tibble(
            cat = data$cat,
            `2022` = as.numeric(
                table(
                    cut(
                        dataset$jif2021,
                        breaks = c(0:(length(data$cat) - 1), Inf)
                    )
                )
            )
        )
    )

    data <- data |> dplyr::bind_rows(
        data |> dplyr::summarize(cat = "Sum", dplyr::across(-cat, sum))
    )

    write.csv(
        data,
        file = file,
        row.names = FALSE,
        fileEncoding = "UTF-8"
    )
}
