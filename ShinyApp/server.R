library(shiny)
library(rpivotTable)


myrowlist = c('Subsubsector')
mycollist = c('Year')
deflt_aggr = 'Sum'
deflt_vals = 'Capacity'
deflt_view = 'Heatmap'
tmp = names(tmplist[1])
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
  output$ele_indicatorspivottable <- renderRpivotTable({
    rpivotTable(
      pwr_indicators,
      rows = 'Case',
      col = 'Year',
      aggregatorName = 'Sum',
      vals = 'Elec_price_RpkWh',
      rendererName = 'Line Chart'
    )
  })
  output$pwremispivottable <- renderRpivotTable({
    rpivotTable(
      pwr_emis,
      rows='Emissions',
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(myinclusion)),
      vals='GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
    
  })
  
  #========================================================
  
  output$refemispivottable <- renderRpivotTable({
    rpivotTable(
      refs_emis,
      rows='Emissions',
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(myinclusion)),
      vals='GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
    
  })
  
  #RESIDENTIAL ==================================
  output$resfpivottable <- renderRpivotTable({
    rpivotTable(
      res_flows,
      rows=c('Subsector','Subsubsector'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals='F_IN',
      rendererName = deflt_view
    )
  })
  output$rescpivottable <- renderRpivotTable({
    rpivotTable(
      res_cost,
      rows= c('Subsector','Subsubsector'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals='Allcosts',
      rendererName = deflt_view
    )
  })
  
  output$resemispivottable <- renderRpivotTable({
    rpivotTable(
      res_emis,
      rows=c('Emissions_source'),
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(myinclusion)),
      vals='GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  #   ============================
  
  
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
  
  #INDUSTRy ================================
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
      rows=c('Subsector','Commodity_Name'),
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
      vals= 'Allcosts',
      rendererName = deflt_view
    )
  })
  
  output$indemispivottable <- renderRpivotTable({
    rpivotTable(
      ind_emis,
      rows=c('Emissions_source'),
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(myinclusion)),
      vals='GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  #     ===================================
  
  
  # TRANSPORT ===================================
  
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
      rows=c('Subsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'Capacity',
      rendererName = 'Stacked Bar Chart'
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
      rows=c('Subsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'NCAPL',
      rendererName = 'Stacked Bar Chart'
    )
    
  })
  
  output$traemispivottable <- renderRpivotTable({
    rpivotTable(
      tra_emis,
      rows=c('Emissions'),
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(myinclusion)),
      vals='GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  
  #REFINERIES =============================================
  
  output$refcappivottable <- renderRpivotTable({
    rpivotTable(
      refs_cap,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'Capacity',
      rendererName = 'Stacked Bar Chart'
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
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'Allcosts',
      rendererName = 'Stacked Bar Chart'
    )
    
  })
  output$refncappivottable <- renderRpivotTable({
    rpivotTable(
      refs_ncap,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'NCAPL',
      rendererName = 'Stacked Bar Chart'
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
  # COMMERCE =========================================
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
  
  output$comemispivottable <- renderRpivotTable({
    rpivotTable(
      com_emis,
      rows=c('Emissions'),
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(myinclusion)),
      vals='GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  output$allemispivottable <- renderRpivotTable({
    rpivotTable(
      all_emis,
      rows=c('Sector'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(myinclusion)),
      vals= 'GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
    
  })
  output$EBpivottable <- renderRpivotTable({
    rpivotTable(
      EB,
      rows=c('Sector'),
      col = 'Commodity_Name',
      aggregatorName=deflt_aggr,
      inclusions = list(Year = list('2006')),
      vals= 'flow_PJ',
      rendererName = 'Table'
    )
    
  })
  
})