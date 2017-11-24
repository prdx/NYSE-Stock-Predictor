# load required libraries
library(shiny)
source("Client/api.R")

# Populate data needed by the GUI initially
inputMethods <- c("Ticker", "Name", "Sector")
sectors_list <- getSectorList()

# Setup the layout
ui <- fluidPage(
  titlePanel("NYSE Stock Price Predictor"),
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
  mainPanel(dataTableOutput("table")))
  
server <- function(input, output) { 
  # We need to wait until user click the submit button before sending any 
  # data to server
  data <- eventReactive(input$submit, {
    switch(
      input$inputMethod,
      Sector = postSector(input$sectorDropdown),
      Name = postName(input$nameText),
      Ticker = postTicker(input$tickerText)
      )
  })
  
  # We don't escape HTML that we embed to the data frame in helper.R
  output$table <- renderDataTable({
    data()
  }, escape = FALSE)
}    

runApp(list(ui=ui, server=server))