box::use(
  R6[R6Class],
  shiny[reactiveValues],
  AmesHousing[make_ames]
)

#' @export
DataManager <- R6::R6Class(
  classname = "DataManager",
  public = list(
    dataset = make_ames()
  )
)
