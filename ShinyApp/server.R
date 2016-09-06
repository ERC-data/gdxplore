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
  output$pwr1pivottable <- renderRpivotTable({
    rpivotTable(
      pwr1,
      rows=myrowlist,
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals=deflt_vals,
      rendererName = deflt_view
    )
    
  })
  output$pwr2pivottable <- renderRpivotTable({
    rpivotTable(
      pwr2,
      rows=myrowlist,
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals=deflt_vals,
      rendererName = deflt_view
    )
    
  })
  output$pwr3pivottable <- renderRpivotTable({
    rpivotTable(
      pwr3,
      rows=myrowlist,
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals=deflt_vals,
      rendererName = deflt_view
    )
    
  })
  output$pwr4pivottable <- renderRpivotTable({
    rpivotTable(
      pwr4,
      rows=myrowlist,
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals=deflt_vals,
      rendererName = deflt_view
    )
    
  })
  output$resfpivottable <- renderRpivotTable({
    rpivotTable(
      res_flows,
      rows=myrowlist,
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals=deflt_vals,
      rendererName = deflt_view
    )
  })
  output$rescpivottable <- renderRpivotTable({
    rpivotTable(
      res_cost,
      rows=myrowlist,
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals=deflt_vals,
      rendererName = deflt_view
    )
  })
  
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
  output$indfpivottable <- renderRpivotTable({
    rpivotTable(
      ind_flows,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
  })
  output$indcpivottable <- renderRpivotTable({
    rpivotTable(
      ind_costs,
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
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
    
  })
  output$tracappivottable <- renderRpivotTable({
    rpivotTable(
      tra_cap,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'Capacity',
      rendererName = deflt_view
    )
    
  })
  output$trafpivottable <- renderRpivotTable({
    rpivotTable(
      tra_flows,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
    
  })
  output$tracpivottable <- renderRpivotTable({
    rpivotTable(
      tra_costs,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'CST_INVC',
      rendererName = deflt_view
    )
    
  })
  output$trancappivottable <- renderRpivotTable({
    rpivotTable(
      tra_ncap,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'NCAPL',
      rendererName = deflt_view
    )
    
  })
  
  output$refcappivottable <- renderRpivotTable({
    rpivotTable(
      refs_cap,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'Capacity',
      rendererName = deflt_view
    )
    
  })
  output$reffpivottable <- renderRpivotTable({
    rpivotTable(
      refs_flows,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
    
  })
  output$refcpivottable <- renderRpivotTable({
    rpivotTable(
      refs_costs,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'CST_INVC',
      rendererName = deflt_view
    )
    
  })
  output$refncappivottable <- renderRpivotTable({
    rpivotTable(
      refs_ncap,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'NCAPL',
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
  
  output$comfpivottable <- renderRpivotTable({
    rpivotTable(
      com_flows,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
    
  })
  output$comcpivottable <- renderRpivotTable({
    rpivotTable(
      com_costs,
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