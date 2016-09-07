library(shiny)
library(rpivotTable)

shinyUI(navbarPage("GDXplorer",tabPanel('Power',
                                        tabsetPanel(tabPanel('Total Capacity',rpivotTableOutput('pwr1pivottable')),
                                                    tabPanel('New Capacity',rpivotTableOutput('pwr2pivottable')),
                                                    tabPanel('Flows',rpivotTableOutput('pwr3pivottable')),
                                                    tabPanel('Costs',rpivotTableOutput('pwr4pivottable')),
                                                    tabPanel("Emissions",rpivotTableOutput('pwremispivottable')))),
        tabPanel("Residential",
                 tabsetPanel(tabPanel('Flows',rpivotTableOutput('resfpivottable')),
                             tabPanel('Costs',rpivotTableOutput('rescpivottable')))),
        tabPanel("Industry",
                 tabsetPanel(tabPanel('Flows',rpivotTableOutput('indfpivottable')),
                             tabPanel('Costs',rpivotTableOutput('indcpivottable')))),
        tabPanel("Refineries",
                 tabsetPanel(tabPanel('Total Capacity',rpivotTableOutput('refcappivottable')),
                             tabPanel('New Capacity',rpivotTableOutput('refncappivottable')),
                             tabPanel('Flows',rpivotTableOutput('reffpivottable')),
                             tabPanel('Costs',rpivotTableOutput('refcpivottable')),
                             tabPanel("Emissions",rpivotTableOutput('refemispivottable')))),
        tabPanel("Transport",
                 tabsetPanel(tabPanel('Total Capacity',rpivotTableOutput('tracappivottable')),
                             tabPanel('New Capacity',rpivotTableOutput('trancappivottable')),
                             tabPanel('Flows',rpivotTableOutput('trafpivottable')),
                             tabPanel('Costs',rpivotTableOutput('tracpivottable')))),
        tabPanel("Commerce",
                 tabsetPanel(tabPanel('Flows',rpivotTableOutput('comfpivottable')),
                             tabPanel('Costs',rpivotTableOutput('comcpivottable')))),
        tabPanel('VAR ACT',rpivotTableOutput('varpivottable')),
        tabPanel('Coal Prices',rpivotTableOutput('clprpivottable'))
      )#navbarpage
      
)#main panel

