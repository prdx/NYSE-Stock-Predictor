library(shiny)
source("api.R")

# Populate data needed by the GUI initially
inputMethods <- c("Ticker", "Name", "Sector")
sectors_list <- getSectorList()

shinyUI(fluidPage(
  titlePanel("NYSE Stock Price Predictor"),
  # Attach a javascript
  tags$head((HTML("
                  <script type='text/javascript' language='javascript'>
                  function tickerClicked(id){
                  Shiny.onInputChange('tickerLink', id);
                  }
                  </script>
                  "))),
  sidebarPanel(fluidRow(column(
    12,
    radioButtons("inputMethod", "",
                 choices = inputMethods,
                 selected = inputMethods[1])
  )),
  fluidRow(column(
    12,
    conditionalPanel(condition = "input.inputMethod == 'Ticker'",
                     textInput("tickerText", "Ticker Symbol", value = ""))
  )),
  fluidRow(column(
    12,
    conditionalPanel(condition = "input.inputMethod == 'Name'",
                     textInput("nameText", "Company Name", value = ""))
  )),
  fluidRow(column(
    12,
    conditionalPanel(
      condition = "input.inputMethod == 'Sector'",
      selectInput("sectorDropdown",
                  "Select a sector:",
                  choices = sectors_list)
    ),
    actionButton("submit", "Submit")
  ))),
  mainPanel(wellPanel(uiOutput("main")))
  ))