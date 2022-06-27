#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(mtcars)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("mtcars"),

    headerPanel("Mtcars Plotter"),
    sidebarPanel(sliderInput('sampleSize', 'Sample Size', min=10, max=nrow(dataset),
                             value=min(10, nrow(dataset)), step=5, round=0),
                 selectInput('x', 'X', names(dataset)),
                 selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
                 selectInput('color', 'Color', c('None', names(dataset))),
                 # checkboxInput('jitter', 'Jitter'),
                 checkboxInput('smooth', 'Smooth'),
                 selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
                 selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
    ),
    mainPanel(
      plotOutput('plot')  )

}

# Run the application 
shinyApp(ui = ui, server = server)
