box::use(
  R6[R6Class],
  shiny[reactiveValues]
)

#' @export
Variables <- R6::R6Class(
  classname = "Variables",
  public = list(
    triggers = reactiveValues(plot = 0),
    trigger_plot = function() {
      self$triggers$plot <- self$triggers$plot + 1
    },

    varX = NULL,
    varY = NULL,
    set_vars = function(varX, varY) {
      self$varX <- varX
      self$varY <- varY
    }
  )
)
