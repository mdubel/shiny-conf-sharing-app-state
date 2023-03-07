box::use(
  R6[R6Class],
  shiny[reactiveValues]
)

#' @export
Variables <- R6::R6Class(
  classname = "Variables",
  public = list(
    state = reactiveValues(trigger = 0),
    varX = NULL,
    varY = NULL,
    set_vars = function(varX, varY) {
      self$varX <- varX
      self$varY <- varY
      private$trigger_render()
    }
  ),
  private = list(
    trigger_render = function() {
      self$state$trigger <- self$state$trigger + 1
    }
  )
)
