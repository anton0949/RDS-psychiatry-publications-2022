create_report <- function(
    title,
    department,
    historical_path,
    dataset_file,
    excluded_file,
    jif_file,
    authors
) {
    fullxml    <- xml2::read_xml(dataset_file)
    references <- xml2::xml_find_all(fullxml, "//record")
    dataset <- here::here("Analysis", "Output", "dataset.csv")
    jif <- readr::read_csv(
        jif_file,
        show_col_types = FALSE
    )

    build_reference_database(
        references = references,
        authortypes = authors,
        excluded = readr::read_csv(
            excluded_file,
            show_col_types = FALSE
        ),
        jif = jif,
        file = dataset
    )

    build_tables_and_figures(
        dataset_file = dataset,
        historical_path = historical_path
    )

    write.csv(
        data.frame(
            "footer" = title,
            "department" = department,
            "dataset_file" = dataset_file
        ),
        file = here::here("Analysis", "Output", "report_data.csv"),
        row.names = FALSE,
        fileEncoding = "UTF-8"
    )
}
