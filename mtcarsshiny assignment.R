library(shiny)
library(tidyverse)
install.packages("mtcars")
view(mtcars)
ui <- fluidPage(textInput(inputId = "mpg", 
                          label = "MPG", 
                          value = "", 
                          placeholder = "21.0"),
                selectInput(inputId = "am", 
                            label = "AM", 
                            choices = list(yes = "1",
                                           no = "0")),
                sliderInput(inputId = "hp",
                            label = "HP",
                            min = min(mtcars$hp),
                            max = max(mtcars$hp),
                            value = c(min(mtcars$hp),
                                      max(mtcars$hp)),
                            sep = ""),
                plotOutput(outputId = "nameplot")) 


server <- function(input, output){
  output$nameplot <- renderPlot({
    
    mtcars%>%
      
      filter(am == input$am,
             mpg == input$mpg)%>%
      
      ggplot(aes(x = hp,
                 y = mpg))+
      geom_line()+
      scale_x_continuous(limits = input$hp)+
      theme_bw()
  })
  
}


shinyApp(ui = ui, server = server)


