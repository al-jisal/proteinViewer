#' prototype UI Function
#'
#' @description this module is the first prototype of proteinViewer.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_prototype_ui <- function(id) {
  ns <- NS(id)

  #################### HEADER ####################
  header <- dashboardHeader(
    title = "Protein Viewer"
  )

  #################### SIDEBAR ####################
  sidebar <- dashboardSidebar(
    # use varSelectInput when I have access to the data
    # varSelectInput(inputId, label, data, selected = NULL, multiple = FALSE)
    # input area for Protein Selection
    varSelectInput("protein", "Protein Name", c("A", "B", "C")),
    # input area for Sex selection
    varSelectInput("sex", "Sex", c("male", "female"), multiple = TRUE),
    # input area for Age selection
    varSelectInput("age", "Age", c("young", "old"), multiple = TRUE),
    # input area for Strain selection
    varSelectInput("strain", "Strain", c("A", "B", "C"), multiple = TRUE),
    # button to update the plot when the user changes any input(s)
    actionButton("update", "Apply Changes",
                 icon("refresh"), class = "btn-success") # updates the plot
  )

  #################### BODY ####################
  body <- dashboardBody(
    h4("Filtered proteins:"),
    uiOutput(ns("content"))
  )

  tagList(
    # Pieces the dashboard's components together
    dashboardPage(header, sidebar, body)
  )
}

#' prototype Server Functions
#'
#' @noRd
mod_prototype_server <- function(id){
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}

## To be copied in the UI
# mod_prototype_ui("prototype_1")
## To be copied in the server
# mod_prototype_server("prototype_1")
