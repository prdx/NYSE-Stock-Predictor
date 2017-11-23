library(shiny)

server0 <- function(input, output) {} 

inputMethods <- c("Ticker", "Name", "Sector")

ui <- fluidPage(
  titlePanel("Stock price predictor"),
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
    condition = "input.inputMethod == 'Sector'"
    )))
  )
runApp(list(ui=ui, server=server0))