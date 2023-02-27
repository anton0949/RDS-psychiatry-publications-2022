#' Builds the CSV reference database for further analysis
#' based on the relevant datafile
#'
#' @param references  Endnote XML records elements
#' @param authortypes author database
#' @param excluded    exclution database
#' @param jif         jif database
#' @param file        file name to save NB. include .csv
#'
#' @return void
build_reference_database <- function(
    references,
    authortypes,
    excluded,
    jif,
    file
) {
    dataset <- tibble::tibble(
        formatted   = character(),
        firstlast   = numeric(),
        excluded    = numeric(),
        firstauthor = character(),
        journal     = character()
    )

    # Loop through the XML files in the directory
    for (reference in references) {
        string <- ""
        authors <- xml2::xml_find_all(reference, ".//author")

        co <- FALSE
        firstlast <- FALSE

        firstauthor <- xml2::xml_text(authors[1])
        journal <- xml2::xml_text(
            xml2::xml_find_first(reference, ".//secondary-title")
        )

        for (i in seq_len(length(authors))) {
            author <- authors[i]
            name <- xml2::xml_text(author)

            if (name %in% authortypes$name) {
                if (i == 1) {
                    firstlast <- TRUE
                } else if (i == length(authors)) {
                    firstlast <- TRUE
                } else {
                    co <- TRUE
                }

                name <- paste0("**", name, "**")
            }

            string <- paste0(string, name)

            if (i < length(authors) - 1) {
                string <- paste0(string, ", ");
            }

            if (i == length(authors) - 1) {
                string <- paste0(string, " & ");
            }
        }

        doi <- xml2::xml_text(
            xml2::xml_find_first(reference, ".//electronic-resource-num")
        )

        link <- xml2::xml_text(
            xml2::xml_find_first(reference, ".//url")
        )

        linkdoi <- doi;

        if (!is.na(link)) {
            linkdoi <- paste0(
                "[",
                doi,
                "](",
                link,
                ")"
            );
        }

        journal_no_txt <- ""
        journal_no <- xml2::xml_text(
            xml2::xml_find_first(reference, ".//number")
        )

        if (!is.na(journal_no)) {
            journal_no_txt <- paste0(
                "(",
                journal_no,
                ")"
            )
        }

        string <- paste0(
            string,
            "&nbsp;&nbsp;&nbsp;",
            xml2::xml_text(
                xml2::xml_find_first(reference, ".//title")
            ),
            ".&nbsp;&nbsp;&nbsp;_",
            journal,
            "_, ",
            xml2::xml_text(
                xml2::xml_find_first(reference, ".//volume")
            ),
            journal_no_txt,
            ":",
            xml2::xml_text(
                xml2::xml_find_first(reference, ".//pages")
            ),
            ".&nbsp;&nbsp;&nbsp;DOI: ",
            linkdoi
        )

        dataset <- dataset |> tibble::add_row(
            formatted   = string,
            firstlast   = firstlast,
            excluded    = (!firstlast && !co) || doi %in% excluded$doi,
            firstauthor = firstauthor,
            journal     = journal
        );
    }

    dataset <- dataset |> dplyr::left_join(jif)

    write.csv(
        dataset |> dplyr::arrange(firstauthor),
        file = file,
        row.names = FALSE,
        fileEncoding = "UTF-8"
    )
}
