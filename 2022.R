# Load project
source(here::here("Analysis", "build_reference_database.R"))
source(here::here("Analysis", "build_tables_and_figures.R"))
source(here::here("Analysis", "Element", "overview_table.R"))
source(here::here("Analysis", "Element", "distribution_table.R"))
source(here::here("Analysis", "Element", "count_figure.R"))
source(here::here("Analysis", "Element", "mean_figure.R"))
source(here::here("Analysis", "Element", "median_figure.R"))
source(here::here("Analysis", "Element", "distribution_figure.R"))
source(here::here("Analysis", "Element", "single_bar_chart.R"))
source(here::here("Analysis", "Element", "multiple_bar_chart.R"))
source(here::here("Analysis", "create_report.R"))

# Color constants
orange <- "#c55a11"
blue <- "#2f5597"
green <- "#548235"

# Load font
sysfonts::font_add_google("Playfair Display", family = "reportfont")
showtext::showtext_auto()

create_report(
    title = "Publications from the departments of Adult Psychiatry in the Region of Southern Denmark, 2022",
    department = "Adult Psychiatry",
    historical_path = here::here("Data", "Historical", "Adult"),
    dataset_file = here::here("Data", "2022.xml"),
    excluded_file = here::here("Data", "excluded.csv"),
    jif_file = here::here("Data", "jif.csv"),
    authors = readr::read_csv(
        here::here("Data", "authors.csv"),
        show_col_types = FALSE
    ) |> dplyr::filter(type == "ADULT")
)

# STOP HERE - knit adult report!

create_report(
    title = "Publications from the departments of Child \\& Adolescent Psychiatry in the Region of Southern Denmark, 2022",
    department = "Child \\& Adolescent Psychiatry",
    historical_path = here::here("Data", "Historical", "BUP"),
    dataset_file = here::here("Data", "2022.xml"),
    excluded_file = here::here("Data", "excluded.csv"),
    jif_file = here::here("Data", "jif.csv"),
    authors = readr::read_csv(
        here::here("Data", "authors.csv"),
        show_col_types = FALSE
    ) |> dplyr::filter(type == "BUP")
)
