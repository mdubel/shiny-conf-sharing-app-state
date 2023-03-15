box::use(
  shiny[...],
)

box::use(
  app/logic/variablesManager[Variables],
  app/logic/dataManager[DataManager],
  app/view/scatterplot,
  app/view/varselect
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  bootstrapPage(
    titlePanel("Ames Housing Data Explorer"),
    fluidRow(
      column(
        width = 3,
        wellPanel(
          varselect$ui(ns("plot1_vars"))
        )
      ),
      column(
        width = 3,
        scatterplot$ui(ns("plot1"))
      ),
      column(
        width = 3,
        scatterplot$ui(ns("plot2"))
      ),
      column(
        width = 3,
        wellPanel(
          varselect$ui(ns("plot2_vars"))
        )
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    DataManager <- DataManager$new()

    Variables1 <- Variables$new()
    Variables2 <- Variables$new()

    varselect$server("plot1_vars", Variables1)
    varselect$server("plot2_vars", Variables2)

    scatterplot$server("plot1", Variables1, DataManager)
    scatterplot$server("plot2", Variables2, DataManager)
  })
}
