box::use(
  shiny[...],
  AmesHousing[make_ames],
  ggplot2[...],
  scales[comma, dollar]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  bootstrapPage(
    plotOutput(ns("plot"))
  )
}

#' @export
server <- function(id, variables) {
  moduleServer(id, function(input, output, session) {
    ames <- make_ames()

    plot_labeller <- function(l, varname) {
      if (varname == "Sale_Price") {
        res <- dollar(l)
      } else {
        res <- comma(l)
      }
      return(res)
    }

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

    output$plot <- renderPlot({
      variables$state$trigger
      scatter_sales(ames, xvar = variables$varX, yvar = variables$varY)
    })
  })
}
