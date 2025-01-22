#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
app_ui <- function(request) {
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
  body <- dashboardBody()

  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Pieces the dashboard's components together
    dashboardPage(header, sidebar, body)
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "proteinViewer"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
