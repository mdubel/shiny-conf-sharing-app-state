box::use(
  shiny[...],
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  # define choices for X and Y variable selection
  var_choices <- list(
    `Sale price` = "Sale_Price",
    `Total basement square feet` = "Total_Bsmt_SF",
    `First floor square feet` = "First_Flr_SF",
    `Lot Frontage` = "Lot_Frontage",
    `Lot Area` = "Lot_Area",
    `Masonry vaneer area` = "Mas_Vnr_Area",
    `1st floor square feet` = "First_Flr_SF",
    `2nd floor square feet` = "Second_Flr_SF",
    `Low quality finished square feet` = "Low_Qual_Fin_SF",
    `Above grade living area square feet` = "Gr_Liv_Area",
    `Garage area square feet` = "Garage_Area"
  )

  # assemble UI elements
  tagList(
    selectInput(
      ns("xvar"),
      "Select X variable",
      choices = var_choices,
      selected = "Lot_Area"
    ),
    selectInput(
      ns("yvar"),
      "Select Y variable",
      choices = var_choices,
      selected = "Sale_Price"
    )
  )
}

#' @export
server <- function(id, variables) {
  moduleServer(id, function(input, output, session) {
    observeEvent(list(input$xvar, input$yvar), {
      variables$set_vars(input$xvar, input$yvar)
      variables$trigger_plot()
    })
  })
}
