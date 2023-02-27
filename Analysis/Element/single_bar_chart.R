#' Generates and saves bar chart for fig. 1 etc.
#'
#' @param name    file name. NB.: must contain file type e.g. .jpeg
#' @param data    plot data
#' @param x       x axis data
#' @param y       x axis data
#' @param color   bar color (hex # incl.)
#' @param min     y axis limit
#' @param max     y axis limit
#' @param step    y axis guideline steps
#' @param x_label x axis label
#' @param y_label y axis label
#'
#' @return void
single_bar_chart <- function(
    name,
    data,
    x,
    y,
    color,
    min,
    max,
    step,
    x_label,
    y_label
) {
    ggplot2::ggplot(
        data = data,
        ggplot2::aes(x = x, y = y)
    ) +
    ggplot2::geom_col(width = .35, fill = color) +
    ggplot2::geom_text(
        ggplot2::aes(label = y),
        vjust = -1,
        size = 7,
        family = "reportfont"
    ) +
    ggplot2::labs(
        y = y_label,
        x = x_label,
    ) +
    ggplot2::scale_x_continuous(breaks = data$year) +
    ggplot2::scale_y_continuous(
        limits = c(min, max),
        breaks = seq(min, max, by = step),
        minor_breaks = seq(0, 0, by = 0)
    ) +
    ggplot2::theme_set(ggplot2::theme_minimal()) +
    ggplot2::theme(
        panel.grid = ggplot2::element_blank(),
        panel.grid.major.y = ggplot2::element_line(
            color = "#00121930",
            linewidth = ggplot2::rel(.3)
        ),
        panel.grid.minor.y = ggplot2::element_line(
            color = "#00121930",
            linewidth = ggplot2::rel(.3)
        ),
        axis.text = ggplot2::element_text(color = "#000000"),
        text = ggplot2::element_text(size = 30, family = "reportfont"),
        aspect.ratio = 1 / 2
    )

    ggplot2::ggsave(name, width = 10, height = 5, dpi = 150)
}
