#################### LOAD DATA ####################
path <- "data/LOAD2.ABCA7_normalizedabundance_withmetadata_proteomics.csv"
data <- read.csv(path)
proteins <- data[, 8:ncol(data)] # proteins are columns 8 to the end

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
    # input area for Protein Selection
    varSelectInput("protein", "Protein Name", proteins),
    # input area for Sex selection
    selectInput("sex", "Sex", c("male", "female")),
    # input area for Age selection
    selectInput("age", "Age", c("4", "12", "18", "24")),
    # input area for Strain selection
    selectInput("strain", "Strain", c("B6", "LOAD2", "LOAD2.ABCA7")),
    # button to update the plot when the user changes any input(s)
    actionButton("update", "Apply Changes",
                 icon("refresh"), class = "btn-success") # updates the plot
  )

  #################### BODY ####################
  body <- dashboardBody(
    h4("Filtered proteins:"),
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
