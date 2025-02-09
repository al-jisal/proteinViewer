# ---------------------------- LOAD DATA ---------------------------------------
load("data/LOAD2.ABCA7_Proteomics.RData")
data <- LOAD2.ABCA7_normalizedabundance_withmetadata_proteomics
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

  # ---------------------------- HEADER ----------------------------------------
  header <- dashboardHeader(
    title = "Protein Viewer"
  )

  # ---------------------------- SIDEBAR ---------------------------------------
  sidebar <- dashboardSidebar(
    # input area for Protein Selection
    varSelectInput(ns("protein"), "Protein Name", proteins),
    # input area for Sex selection
    selectInput(ns("sex"), "Sex", unique(data$Sex)),
    # input area for Age selection
    selectInput(ns("age"), "Age", unique(as.numeric(data$Age))),
    # input area for Strain selection
    selectInput(ns("strain"), "Strain", unique(data$Genotype)),
    # button to update the plot when the user changes any input(s)
    actionButton(ns("update"), "Apply Changes", width = "87%",
                 icon("refresh"), class = "btn-success") # updates the plot
  )

  # ---------------------------- BODY ------------------------------------------
  body <- dashboardBody(
    h4("Filtered proteins:"),
    plotOutput("boxplot")
  )

  tagList(
    # Pieces the dashboard's components together
    dashboardPage(header, sidebar, body)
  )
}

#' prototype Server Functions
#'
#' @noRd
mod_prototype_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # Reactive dataset triggered only when the "Apply Changes" button is pressed
    filtered_data <- eventReactive(input$update, {
      req(input$protein)  # Ensure a protein is selected

      data %>%
        filter(Sex == input$sex,
               Age == as.numeric(input$age),
               Genotype == input$strain) %>%
        select(Genotype, all_of(as.character(input$protein)))
    })

    # Render the box plot
    output$boxplot <- renderPlot({
      req(filtered_data())  # Ensure data is available

      ggplot(filtered_data(), aes(x = Genotype,
                                  y = .data[[as.character(input$protein)]])
      ) +
        geom_boxplot(fill = "skyblue", color = "black") +
        labs(title = paste("Expression of", as.character(input$protein)),
             x = "Strain",
             y = "Expression Level") +
        theme_minimal()
    })
  })
}
