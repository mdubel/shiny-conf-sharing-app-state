box::use(
  shiny[...],
  ggplot2[...],
  scales[comma, dollar]
)

#' @export
plot_labeller <- function(l, varname) {
  if (varname == "Sale_Price") {
    res <- dollar(l)
  } else {
    res <- comma(l)
  }
  return(res)
}

#' @export
scatter_sales <- function(dataset, xvar, yvar) {

  x <- rlang::sym(xvar)
  y <- rlang::sym(yvar)

  p <- ggplot(dataset, aes(x = !!x, y = !!y)) +
    geom_point() +
    scale_x_continuous(labels = function(l) plot_labeller(l, varname = xvar)) +
    scale_y_continuous(labels = function(l) plot_labeller(l, varname = yvar)) +
    theme(axis.title = element_text(size = rel(1.2)),
          axis.text = element_text(size = rel(1.1)))

  return(p)
}

#' @export
ui <- function(id) {
  ns <- NS(id)
  bootstrapPage(
    plotOutput(ns("plot"))
  )
}

#' @export
server <- function(id, variables, data) {
  moduleServer(id, function(input, output, session) {
    output$plot <- renderPlot({
      variables$triggers$plot
      scatter_sales(data$dataset, xvar = variables$varX, yvar = variables$varY)
    })
  })
}
