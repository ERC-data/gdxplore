library(shiny)
library(rpivotTable)


myrowlist = c('Subsubsector')
mycollist = c('Year')
deflt_aggr = 'Sum'
deflt_vals = 'Capacity'
deflt_view = 'Heatmap'
myinclusion = '01REF' #NOTE This will have to be automatic

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
 
  #prcgdxfilepath <- input$prcgdxfilepath
  #prcgdxfilepath <- prcgdxfilepath$datapath#get the path
  
  output$pwrpivottable <- renderRpivotTable({
    rpivotTable(
      pwrdf,
      rows=myrowlist,
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals=deflt_vals,
      rendererName = deflt_view
    )
  })
  output$indpivottable <- renderRpivotTable({
    rpivotTable(
      inddf,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
    })
  output$trapivottable <- renderRpivotTable({
    rpivotTable(
      tradf,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
    
  })
  output$respivottable <- renderRpivotTable({
    rpivotTable(
      resdf,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
    
  })
  output$compivottable <- renderRpivotTable({
    rpivotTable(
      comdf,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
    
  })
  output$varpivottable <- renderRpivotTable({
    rpivotTable(
      varactdf,
      rows=c('Case','Subsubsector'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'VAR_ACT',
      rendererName = deflt_view
    )
    
  })
  output$clprpivottable <- renderRpivotTable({
    rpivotTable(
      clpricesdf,
      rows=c('Case'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'avgCLpriceAll',
      rendererName = 'Line Chart'
    )
    
  })
})