#' prototype UI Function
#'
#' @description A shiny Module.
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
    h4("Search for a protein below"),
    sidebarSearchForm(textId = "search", buttonId = "searchButton", label = "Search..."),

    # use varSelectInput when I have access to the data
    selectInput("sex", "Sex", c("male", "female"), selected = "male", multiple = TRUE),
    selectInput("age", "Age", c("young", "old"), selected = "young", multiple = TRUE),
    selectInput("strain", "Strain", c("A", "B", "C"), selected = "A", multiple = TRUE),

    submitButton("Apply Changes", icon("refresh")) # updates the plot
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
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    # dummy data serving as a placeholder for the actual data
    proteins <- c("aab", "aaf", "add", "blurr", "blurb", "Can")
    # filter the proteins based on the search input
    # return the matched proteins
    filtered_proteins <- reactive({
      search_term <- tolower(input$search)
      if (length(search_term) == 0){
        return("") # return all proteins if search term is empty
      }
      matched_proteins <- proteins[grep(search_term, tolower(proteins))]
      return(matched_proteins)
    })

    # render the matched proteins
    output$content <- reactive({
      if(length(filtered_proteins()) == 0){
        return("No proteins found")
      }
      return(list_to_li(filtered_proteins()))
    })
  })
}

## To be copied in the UI
# mod_prototype_ui("prototype_1")
    
## To be copied in the server
# mod_prototype_server("prototype_1")
