#
# File  : server.R
# About : Project work for the Developing Data Products class
# Author: Gopinathan Balaji
# Date  : 14 DEC 2014
#

library(shiny)

# Simplify the Theoph dataset by consolidating two 
# variables (Wt and Dose) into one (GivenDose)
data(Theoph)
simTh <- Theoph
simTh$GivenDose <- Theoph$Wt * Theoph$Dose
lmTh <- lm(conc ~ Time + GivenDose,
           simTh)

shinyServer(function(input, output) {
  output$oGivenDose <- renderText(input$iGivenDose)
  output$oTime <- renderText(input$iTime)  
  the.future <- reactive({
    newdata.df <- data.frame(GivenDose = as.numeric(input$iGivenDose), 
                             Time = as.numeric(input$iTime))
    predict(lmTh, 
            newdata = newdata.df, 
            interval = "prediction", type="response")
  })
  output$oModelPlot <- renderPlot({
    plot(simTh$Time, simTh$conc,
         main = "Drug concentration over time",
         xlab = "Time since drug administration (hr)",
         ylab = "Drug concentration (mg/L)"
         )
    abline(v=as.numeric(input$iTime), 
           col='red',
           lwd=3)
    abline(lmTh, 
           col='blue',
           lwd=3)
    })  
  output$oModelSummary <- renderPrint(the.future())
})
