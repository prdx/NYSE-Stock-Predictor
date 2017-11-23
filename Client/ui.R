# load required libraries
library(shiny)

server0 <- function(input, output) {} 

# Ticker <- stock symbol
# Name <- stock Name
# Sector <- Industry Sector

inputMethods <- c("Ticker", "Name", "Sector")
# tmp <- read_csv("your path")
# tmp2 <- levels(factor(tmp$Sector))
# sector_list <- tmp2

# TODO
# make a list of companies belonging to each sector

# ui method
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
                "Select a sector:", choices=sector_list, selected="Energy"),
    tableOutput("datatable") )
  )))
  
server <- function(input, output) { output$datatable <- renderTable({
  pos <- which(search() == "Energy")
  get(input$sector, pos=pos) })
}  
  

runApp(list(ui=ui, server=server))


