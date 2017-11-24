# load required libraries
library(shiny)
source("Client/api.R")

inputMethods <- c("Ticker", "Name", "Sector")

sectors_list <- getSectorList()

ui <- fluidPage(
  titlePanel("Stock price predictor"),
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
  mainPanel(tableOutput("table")))
  
server <- function(input, output) { 
  data <- eventReactive(input$submit, {
    switch(
      input$inputMethod,
      Sector = postSector(input$sectorDropdown),
      Name = postName(input$nameText),
      Ticker = postTicker(input$tickerText)
      )
  })
  
  output$table <- renderTable({
    data()
  })
}    

runApp(list(ui=ui, server=server))