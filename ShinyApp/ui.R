source('setup.R', chdir=T)

shinyUI(navbarPage(title = 'SATIMviz', id = 'mainMenu',
                   
# Sidebar Layout
    tabPanel('Scenario Selection', 
        sidebarLayout(
            sidebarPanel(
                checkboxInput('ckan', label = 'CKAN', value = FALSE),
                conditionalPanel(
                    condition = "input.ckan == true",
                    selectizeInput('projects', 'Project list', NULL, multiple = FALSE, choices = projects)
                ),
                selectizeInput('group', 'Scenario list', NULL, multiple = TRUE, choices = rdslist(dataset)),
                actionButton("results",'View results')
                ),
            mainPanel(verbatimTextOutput('row')))
            ),
 
# Main Menu Tabs                
    tabPanel('Power',
            tabsetPanel(tabPanel('Total Capacity',rpivotTableOutput('pwr_cappivottable'),value = 'totalcapacity'),
                        tabPanel('New Capacity',rpivotTableOutput('pwr_ncappivottable')),
                        tabPanel('Flows',rpivotTableOutput('pwr_flowspivottable')),
                        tabPanel('Costs',rpivotTableOutput('pwr_costspivottable')),
                        tabPanel("Emissions",rpivotTableOutput('pwremispivottable')),
                        tabPanel('Indicators',rpivotTableOutput('ele_indicatorspivottable')),
                        id = 'powertabs')
            ),
    
    tabPanel("Residential",
             tabsetPanel(tabPanel('Flows',rpivotTableOutput('resfpivottable')),
                         tabPanel('Costs',rpivotTableOutput('rescpivottable')),
                         tabPanel('Emissions',rpivotTableOutput('resemispivottable')))
             ),
    
    tabPanel("Industry",
             tabsetPanel(tabPanel('Flows',rpivotTableOutput('indfpivottable')),
                         tabPanel('Costs',rpivotTableOutput('indcpivottable')),
                         tabPanel('Emissions',rpivotTableOutput('indemispivottable')))
             ),
    
    tabPanel("Refineries",
             tabsetPanel(tabPanel('Total Capacity',rpivotTableOutput('refcappivottable')),
                         tabPanel('New Capacity',rpivotTableOutput('refncappivottable')),
                         tabPanel('Flows',rpivotTableOutput('reffpivottable')),
                         tabPanel('Costs',rpivotTableOutput('refcpivottable')),
                         tabPanel("Emissions",rpivotTableOutput('refemispivottable')))
             ),

    tabPanel("Transport",
             tabsetPanel(tabPanel('Total Capacity',rpivotTableOutput('tracappivottable')),
                         tabPanel('New Capacity',rpivotTableOutput('trancappivottable')),
                         tabPanel('Flows',rpivotTableOutput('trafpivottable')),
                         tabPanel('Costs',rpivotTableOutput('tracpivottable')),
                         tabPanel("Emissions",rpivotTableOutput('traemispivottable')))
             ),

    tabPanel("Commerce",
             tabsetPanel(tabPanel('Flows',rpivotTableOutput('comfpivottable')),
                         tabPanel('Costs',rpivotTableOutput('comcpivottable')),
                         tabPanel("Emissions",rpivotTableOutput('comemispivottable')))
             ),

    tabPanel('Emissions',rpivotTableOutput('allemispivottable')),

    tabPanel('Energy Balance',rpivotTableOutput('EBpivottable'))
))
