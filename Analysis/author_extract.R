local({
    # Don't overwrite if manual changes are made
    authors_data <- readr::read_csv(
        here::here("Data", "authors.csv"),
        show_col_types = FALSE
    )

    fullxml <- xml2::read_xml(
        here::here("Data", "2022.xml"),
        show_col_types = FALSE
    )

    references <- xml2::xml_find_all(fullxml, "//record")

    for (reference in references) {
        authors <- xml2::xml_find_all(reference, ".//author")

        for (author in authors) {
            name <- xml2::xml_text(author)

            # Add author name if not existing
            if (any(authors_data$name == name) == FALSE) {
                authors_data <- authors_data |> tibble::add_row(
                    name = name
                )
            }
        }
    }

    # Save new author list
    write.csv(
        authors_data |> dplyr::arrange(name),
        file = here::here("Data", "authors.csv"),
        row.names = FALSE,
        fileEncoding = "UTF-8"
    )
})
