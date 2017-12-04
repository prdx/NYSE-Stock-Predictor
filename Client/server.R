library(shiny)
source("api.R")

shinyServer(
  function(input, output) { 
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
                 "<p><b>LM prediction:</b> ", params$companyDetails[["predictedLm"]][[1]], "</p>",
                 "<p><b>Sentiment analysis from the news:</b> ", params$companyDetails[["sentiment_result"]][[1]], "</p>",
                 "<p><i>Note: For the sentiment analysis, closer to +1 implies 'Buy' and closer to -1 implies 'Sell'.</i></p>"
      ))
    })
  }    
)