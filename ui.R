#
# File  : ui.R
# About : Project work for the Developing Data Products class
# Author: Gopinathan Balaji
# Date  : 14 DEC 2014
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Drug concentration predictor (student project)"),  
  
  # Sidebar Layout
  sidebarLayout(    
    # Sidebar Panel
    sidebarPanel(
      a("Click here for help documentation", 
        href="ddp-help-documentation.html", 
        target="_blank"), 
      p("Provide details below."),
      sliderInput("iGivenDose", 
                  "The dose given (mg)", 
                  min=265, max=325, value=315, step=0.1),
      sliderInput("iTime", 
                  "Hours since dose was provided", 
                  min=0, max=24, value=4, step=0.5)
    ),
    
    # Main panel
    mainPanel(
      p("The subject was given ", 
        textOutput("oGivenDose", inline=TRUE),
        "mg, ",
        textOutput("oTime", inline = TRUE), 
        " hours ago."),
      h3("Plot of the data: "), 
      p("Blue line is the fit, red line is the hours input"), 
      plotOutput("oModelPlot", height = 300, width = 500),
      h3("Prediction from model: "), 
      verbatimTextOutput("oModelSummary")
  )
  )
))
