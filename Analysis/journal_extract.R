local({
    # Don't overwrite if manual changes are made
    dataset <- readr::read_csv(
        here::here("Analysis", "Output", "dataset.csv"),
        show_col_types = FALSE
    )

    jif <- readr::read_csv(
        here::here("Data", "jif.csv"),
        show_col_types = FALSE
    )

    new_jif <- jif |> dplyr::full_join(
        dataset |> dplyr::distinct(journal)
    )

    write.csv(
        new_jif |> dplyr::arrange(journal),
        file = here::here("Data", "jif.csv"),
        row.names = FALSE,
        fileEncoding = "UTF-8"
    )
})
