# load required libraries
library(shiny)
source("Client/api.R")

server0 <- function(input, output) {} 

inputMethods <- c("Ticker", "Name", "Sector")

sectors_list <- getSectorList()

# ui method
# TODO
# Display a table of list of companies for a selected sector
# Check pagination
ui <- fluidPage(
  titlePanel("Stock price predictor"),
  fluidRow(column(12,  radioButtons("inputMethod", "", 
                                    choices=inputMethods, 
                                    selected=inputMethods[1])
  )),
  fluidRow(column(12, conditionalPanel(
    condition = "input.inputMethod == 'Ticker'",
    textInput("tickerText", "Ticker Symbol", value="AAPL")
  ))),
  fluidRow(column(12, conditionalPanel(
    condition = "input.inputMethod == 'Name'",
    textInput("nameText", "Company Name", value="Apple")
  ))),
  fluidRow(column(12, conditionalPanel(
    condition = "input.inputMethod == 'Sector'",
    selectInput("sector",
                "Select a sector:",
                choices=sectors_list,
                selected=sectors_list$sector[[3]]),
    tableOutput("sector") )
  )))
  
server <- function(input, output) { 
  output$sector <- renderTable({
    postSector(input$sector)
    })
}    

runApp(list(ui=ui, server=server))