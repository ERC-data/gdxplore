library(shiny)
library(rpivotTable)

# Define UI for application that draws a histogram


shinyUI(fluidPage(
  # Application title
  titlePanel("GDXplorer"),
  #sidebarLayout(
  #  sidebarPanel(
  #    fileInput('prcgdxfilepath', 'Choose File',accept=c('text/gdx','.gdx'))
  #    ),
    mainPanel(
      tabsetPanel(
        #tabPanel("File Manager",rpivotTableOutput("pwrpivottable")),
        tabPanel("Power",rpivotTableOutput("pwrpivottable")),
        tabPanel("Industry",rpivotTableOutput("indpivottable")),
        tabPanel('Transport',rpivotTableOutput('trapivottable')),
        tabPanel('Residential',rpivotTableOutput('respivottable')),
        tabPanel('Commerce',rpivotTableOutput('compivottable')),
        tabPanel('VAR ACT',rpivotTableOutput('varpivottable')),
        tabPanel('Coal Prices',rpivotTableOutput('clprpivottable'))
      )#tabsetpanel
      
    )#main panel
    )
  )
    
  
  
#)
