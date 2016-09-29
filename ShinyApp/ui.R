library(shiny)
library(rpivotTable)
attach('C:/EMOD/RDSfiles/savedRenv.RData')

shinyUI(navbarPage("SATIMviz",tabPanel('Power',
                                        tabsetPanel(tabPanel('Total Capacity',rpivotTableOutput('pwr_cappivottable')),
                                                    tabPanel('New Capacity',rpivotTableOutput('pwr_ncappivottable')),
                                                    tabPanel('Flows',rpivotTableOutput('pwr_flowspivottable')),
                                                    tabPanel('Costs',rpivotTableOutput('pwr_costspivottable')),
                                                    tabPanel("Emissions",rpivotTableOutput('pwremispivottable')),
                                                    tabPanel('Indicators',rpivotTableOutput('ele_indicatorspivottable')))),
        tabPanel("Residential",
                 tabsetPanel(tabPanel('Flows',rpivotTableOutput('resfpivottable')),
                             tabPanel('Costs',rpivotTableOutput('rescpivottable')),
                             tabPanel('Emissions',rpivotTableOutput('resemispivottable')))),
        tabPanel("Industry",
                 tabsetPanel(tabPanel('Flows',rpivotTableOutput('indfpivottable')),
                             tabPanel('Costs',rpivotTableOutput('indcpivottable')),
                             tabPanel('Emissions',rpivotTableOutput('indemispivottable')))),
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
                             tabPanel('Costs',rpivotTableOutput('tracpivottable')),
                             tabPanel("Emissions",rpivotTableOutput('traemispivottable')))),
        tabPanel("Commerce",
                 tabsetPanel(tabPanel('Flows',rpivotTableOutput('comfpivottable')),
                             tabPanel('Costs',rpivotTableOutput('comcpivottable')),
                             tabPanel("Emissions",rpivotTableOutput('comemispivottable')))),
        tabPanel('Emissions',rpivotTableOutput('allemispivottable')),
        tabPanel('Energy Balance',rpivotTableOutput('EBpivottable'))
        
      )#navbarpage
      
)#main panel

