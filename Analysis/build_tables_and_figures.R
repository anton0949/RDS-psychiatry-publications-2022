build_tables_and_figures <- function(
    dataset_file,
    historical_path
) {
    ggplot2::theme_set(ggplot2::theme_minimal())

    references <-
        readr::read_csv(
            dataset_file,
            show_col_types = FALSE
        ) |>
        dplyr::filter(excluded == 0)

    references_first_senior <- references |>
        dplyr::filter(firstlast == 1)

    references_upper <- references |>
        dplyr::filter(jif2021 >= quantile(references$jif2021, 2 / 3))

    references_upper_first_senior <- references_first_senior |>
        dplyr::filter(jif2021 >= quantile(references_first_senior$jif2021, 2 / 3))

    overview_table(
        historical_path = historical_path,
        historical_postfix = "",
        dataset = references,
        here::here("Analysis", "Output", "table1.csv"),
        orange
    )

    overview_table(
        historical_path = historical_path,
        historical_postfix = "_first_senior",
        dataset = references_first_senior,
        here::here("Analysis", "Output", "table2.csv"),
        blue
    )

    overview_table(
        historical_path = historical_path,
        historical_postfix = "_upper",
        dataset = references_upper,
        here::here("Analysis", "Output", "table5.csv"),
        orange
    )

    overview_table(
        historical_path = historical_path,
        historical_postfix = "_upper_first_senior",
        dataset = references_upper_first_senior,
        here::here("Analysis", "Output", "table6.csv"),
        orange
    )

    distribution_table(
        historical_path = historical_path,
        historical_postfix = "",
        dataset = references,
        here::here("Analysis", "Output", "table3.csv"),
        orange
    )

    distribution_table(
        historical_path = historical_path,
        historical_postfix = "_first_senior",
        dataset = references_first_senior,
        here::here("Analysis", "Output", "table4.csv"),
        blue
    )

    count_figure(
        historical_path = historical_path,
        historical_postfix = "",
        dataset = references,
        here::here("Analysis", "Output", "fig1.jpeg"),
        orange
    )

    count_figure(
        historical_path = historical_path,
        historical_postfix = "_first_senior",
        dataset = references_first_senior,
        here::here("Analysis", "Output", "fig5.jpeg"),
        blue
    )

    mean_figure(
        historical_path = historical_path,
        historical_postfix = "",
        dataset = references,
        here::here("Analysis", "Output", "fig2.jpeg"),
        orange
    )

    mean_figure(
        historical_path = historical_path,
        historical_postfix = "_first_senior",
        dataset = references_first_senior,
        here::here("Analysis", "Output", "fig6.jpeg"),
        blue
    )

    mean_figure(
        historical_path = historical_path,
        historical_postfix = "_upper",
        dataset = references_upper,
        here::here("Analysis", "Output", "fig9.jpeg"),
        green
    )

    mean_figure(
        historical_path = historical_path,
        historical_postfix = "_upper_first_senior",
        dataset = references_upper_first_senior,
        here::here("Analysis", "Output", "fig11.jpeg"),
        purple
    )

    median_figure(
        historical_path = historical_path,
        historical_postfix = "",
        dataset = references,
        here::here("Analysis", "Output", "fig3.jpeg"),
        orange
    )

    median_figure(
        historical_path = historical_path,
        historical_postfix = "_first_senior",
        dataset = references_first_senior,
        here::here("Analysis", "Output", "fig7.jpeg"),
        blue
    )

    median_figure(
        historical_path = historical_path,
        historical_postfix = "_upper",
        dataset = references_upper,
        here::here("Analysis", "Output", "fig10.jpeg"),
        green
    )

    median_figure(
        historical_path = historical_path,
        historical_postfix = "_upper_first_senior",
        dataset = references_upper_first_senior,
        here::here("Analysis", "Output", "fig12.jpeg"),
        purple
    )

    distribution_figure(
        table_path = here::here("Analysis", "Output", "table3.csv"),
        dataset = references,
        file = here::here("Analysis", "Output", "fig4.jpeg"),
        orange
    )

    distribution_figure(
        table_path = here::here("Analysis", "Output", "table4.csv"),
        dataset = references_first_senior,
        file = here::here("Analysis", "Output", "fig8.jpeg"),
        blue
    )
}
