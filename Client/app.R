# load required libraries
library(shiny)
source("Client/api.R")

# Populate data needed by the GUI initially
inputMethods <- c("Ticker", "Name", "Sector")
sectors_list <- getSectorList()


# Setup the layout
ui <- fluidPage(
  titlePanel("NYSE Stock Price Predictor"),
  # Attach a javascript
  tags$head((HTML("
                  <script type='text/javascript' language='javascript'>
                    function tickerClicked(id){
                      Shiny.onInputChange('tickerLink', id);
                    }
                  </script>
                  "))),
  sidebarPanel(
    fluidRow(column(12,  radioButtons("inputMethod", "", 
                                      choices=inputMethods, 
                                      selected=inputMethods[1])
    )),
    fluidRow(column(12, conditionalPanel(
      condition = "input.inputMethod == 'Ticker'",
      textInput("tickerText", "Ticker Symbol", value="")
    ))),
    fluidRow(column(12, conditionalPanel(
      condition = "input.inputMethod == 'Name'",
      textInput("nameText", "Company Name", value="")
    ))),
    fluidRow(column(12, conditionalPanel(
      condition = "input.inputMethod == 'Sector'",
      selectInput("sectorDropdown",
                  "Select a sector:",
                  choices=sectors_list)),
    actionButton("submit", "Submit")
  ))),
  mainPanel(
    wellPanel(
      uiOutput("main")
    )
    ))
  
server <- function(input, output) { 
  # Create new reactiveValues storage
  params <- reactiveValues(mainPanelDisplay = 'table')
  
  # We need to wait until user click the submit button before sending any 
  # data to server
  data <- eventReactive(input$submit, {
    # Store what to display
    # If user submit the sidebar, we will display the table
    params$mainPanelDisplay <- "table"
    switch(
      input$inputMethod,
      Sector = postSector(input$sectorDropdown),
      Name = postName(input$nameText),
      Ticker = postTicker(input$tickerText)
      )
  })
  
  observeEvent(input$tickerLink,{
    # Store what to display
    # If user click the ticker link, we will display the detail
    params$mainPanelDisplay <- "detail"
  })
  
  # Dynamically render the main panel
  output$main <- renderUI({
    if (params$mainPanelDisplay == 'table') {
      # We don't escape HTML that we embed to the data frame in helper.R
      output$table <- renderDataTable({
        data()
      }, escape = FALSE)
      dataTableOutput("table")
    }
    else {
      textOutput("clickedTickerText")
    }
  })
  
  output$clickedTickerText <- renderText({params$mainPanelDisplay})
  
}    

runApp(list(ui=ui, server=server))