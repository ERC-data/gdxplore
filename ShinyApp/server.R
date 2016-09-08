library(shiny)
library(rpivotTable)


myrowlist = c('Subsubsector')
mycollist = c('Year')
deflt_aggr = 'Sum'
deflt_vals = 'Capacity'
deflt_view = 'Heatmap'
tmp = paste(gdxlist[1])
myinclusion = strtrim(tmp,nchar(tmp)-4) #NOTE This will have to be automatic

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  #POWER TABS ============================================
  output$pwr_cappivottable <- renderRpivotTable({
    rpivotTable(
      pwr_cap,
      rows= 'Subsector',
      col = mycollist,
      aggregatorName= 'Sum',
      inclusions = list(Case = list(myinclusion)),
      vals= 'Capacity',
      rendererName = 'Stacked Bar Chart'
    )
    
  })
  output$pwr_ncappivottable <- renderRpivotTable({
    rpivotTable(
      pwr_ncap,
      rows=myrowlist,
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'NCAPL',
      rendererName = 'Stacked Bar Chart'
    )
    
  })
  output$pwr_flowspivottable <- renderRpivotTable({
    rpivotTable(
      pwr_flows,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals='F_IN',
      rendererName = deflt_view
    )
    
  })
  output$pwr_costspivottable <- renderRpivotTable({
    rpivotTable(
      pwr_costs,
      rows=c('Subsector','Subsubsector'),
      col = mycollist,
      aggregatorName= 'Sum',
      inclusions = list(Case = list(myinclusion)),
      vals='CST_INVC',
      rendererName = 'Stacked Bar Chart'
    )
    
  })
  
  output$pwremispivottable <- renderRpivotTable({
    rpivotTable(
      pwr_emis,
      rows='Commodity',
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(myinclusion)),
      vals='F_OUT',
      rendererName = 'Stacked Bar Chart'
    )
    
  })
  
  #========================================================
  
  output$refemispivottable <- renderRpivotTable({
    rpivotTable(
      refs_emis,
      rows='Commodity',
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(myinclusion)),
      vals='F_OUT',
      rendererName = 'Stacked Bar Chart'
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