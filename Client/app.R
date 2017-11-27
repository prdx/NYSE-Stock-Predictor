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
)
  
server <- function(input, output) { 
  # Create new server-side reactiveValues storage
  params <- reactiveValues(mainPanelDisplay = 'table', companyDetails = list())
  
  # We need to wait until user click the submit button before sending any 
  # data to server
  data <- eventReactive(input$submit, {
    # We will observe which input method is checked on the radio button
    # and then call the responsible function for each input method
    switch(
      input$inputMethod,
      Sector = postSector(input$sectorDropdown),
      Name = postName(input$nameText),
      Ticker = postTicker(input$tickerText)
      )
  })
  
  observeEvent(input$submit, {
    # Store what to display
    # If user submit the sidebar, we will display the table in the main 
    # panel
    params$mainPanelDisplay <- "table"
  })
  
  observeEvent(input$tickerLink, {
    # Store what to display
    # If user click the ticker link, we will display the detail in the main 
    # panel
    params$mainPanelDisplay <- "detail"
    params$companyDetails <- postDetails(input$tickerLink)
  })
  
  # Here we are determine the logic when rendering main panel
  output$main <- renderUI({
    if (params$mainPanelDisplay == 'table') {
      output$table <- renderDataTable({
        data()
      }, escape = FALSE)
      dataTableOutput("table")
    }
    else {
      htmlOutput("companyDetailsText")
    }
  })
  
  output$companyDetailsText <- renderUI({
    # lmRmse <- getLmRmse()
    HTML(paste("<p><b>Ticker Symbol:</b> ", params$companyDetails[["Ticker Symbol"]][[1]], "</p>",
               "<p><b>Company name:</b> ", params$companyDetails[["Company Name"]][[1]], "</p>",
               "<p><b>Sector:</b> ", params$companyDetails[["Sector"]][[1]], "</p>",
               "<p><b>Industry:</b> ", params$companyDetails[["Industry"]][[1]], "</p>",
               "<p><b>LM prediction:</b> ", params$companyDetails[["predictedLm"]][[1]]
               ))
    })
}    

runApp(list(ui=ui, server=server))