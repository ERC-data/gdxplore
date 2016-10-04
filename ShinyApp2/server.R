
#Server

library(shiny)
source('C:/EMOD/grouprdsfiles.R')#load this function

function(input, output) {
  
  output$row <- renderPrint({
    input$group
  })
  
  the_selection <- eventReactive(input$ViewNowButton,{input$group})
  
  output$row2 <- renderText({the_selection()})

  obs <- observe({
    groupfiles(the_selection)
  })#observe

}
