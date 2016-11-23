source('setup.R', chdir=T)

myrowlist <- c('Subsubsector')
mycollist <- c('Year')
deflt_aggr <- 'Sum'
deflt_vals <- 'Capacity'
deflt_view <- 'Heatmap'

myinclusion = ' '#strtrim(tmp,nchar(tmp)-4) # NOTE This will have to be automatic

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    # Set dataset value based on CKAN checkbox:
    # if unchecked, dataset is NULL
    # if checked, dataset id is retrieved from CKAN
    datasetInput <- reactive({
        switch(
            input$ckan,
            'true' = unlist(projectlist[sapply(projectlist, '[[', 'organization')['title',] == input$ckan_projects])['name'],
            'false' = NULL
        )
    })
    
    # Create dropdown menu with scenario selection based on CKAN checkbox and project selection (datasetInput())
    output$scenarios <- renderUI({
        selectInput('scenario_group', 'Scenario list', NULL, multiple = TRUE, choices = rdslist(datasetInput()))
    })    
    
    # Display selected scenario name and descriptions in main panel
    output$row <- renderPrint({
        if(length(input$scenario_group > 0)){
            if(is.null(datasetInput())){
                input$scenario_group
            } else {
                # Show all the resources belonging to the selected project
                pkg <- package_show(datasetInput(), as = 'table')$resources
                # Create selection of those resources whose name has been selected in the input scenario multiple choice
                selection <- grepl(paste('^', paste(input$scenario_group, collapse="$|^"), '$', sep = ""), pkg$name)
                subset(pkg, selection, select = c('name','description'))
            }}
        })
  
    # Define all dataframes for the pivot tables which will change when button is clicked to group another set of results. Has to be done one by one >.
    variables <- reactiveValues(pwrdf = data.frame(),
                                pwr_cap = data.frame(),
                                pwr_ncap = data.frame(),
                                pwr_flows = data.frame(),
                                pwr_costs = data.frame(),
                                pwr_indicators = data.frame(),
                                EB = data.frame(),
                                tradf = data.frame(),
                                tra_flows = data.frame(),
                                tra_costs = data.frame(),
                                tra_cap = data.frame(),
                                tra_ncap = data.frame(),
                                refs_costs = data.frame(),
                                refs_flows = data.frame(),
                                refs_ncap = data.frame(),
                                refs_cap = data.frame(),
                                pwr_emis = data.frame(),
                                ind_emis = data.frame(),
                                res_emis = data.frame(),
                                com_emis = data.frame(),
                                tra_emis = data.frame(),
                                sup_emis = data.frame(),
                                refs_emis= data.frame(),
                                all_emis = data.frame(),
                                resdf = data.frame(),
                                res_flows = data.frame(),
                                res_cost = data.frame(),
                                inddf = data.frame(),
                                ind_costs = data.frame(),
                                ind_flows = data.frame(),
                                comdf  = data.frame(),
                                com_costs = data.frame(),
                                com_flows = data.frame(),
                                clpricesdf = data.frame(),
                                varactdf = data.frame(),
                                myinclusion = 'temp'
                                )
  
  #READING REACTIVELY THE DATAFRAMES THE USERS WANTS TO VIEW
  
    observeEvent(input$results, {
        print('grouping selection...')
        withProgress(message = 'Grouping Your Selection...',value = 0,{
            groupfiles(input$scenario_group, datasetInput()) # cache user's input selection
            incProgress(1, detail = paste('done'))
            Sys.sleep(0.1)
            updateNavbarPage(session, 'mainMenu', 'Power')
            })
    
        #define empty dataframes
        tmplist = list()
        pwrdf = pwr_cap = pwr_ncap = pwr_flows = pwr_costs = pwr_indicators =EB = 
            tradf = tra_flows = tra_costs = tra_cap = tra_ncap = refs_costs = refs_flows =
            refs_ncap = refs_cap =pwr_emis = ind_emis = res_emis = com_emis = tra_emis =
            sup_emis= refs_emis= all_emis = resdf = res_flows = res_cost = inddf = 
            ind_costs = ind_flows =comdf  = com_costs = com_flows = clpricesdf = varactdf = data.frame()
        
        tmplist = newrds # retrieve cached object from groupfiles function
        
        n = length(tmplist)
        withProgress(message = 'Loading into Viewer',value = 0,{
        for (i in 1:n){
            print(i)
            incProgress(1/n,detail = paste(paste('Loading scenario ',i,sep = ''),'into viewer'))
            pwr_cap = rbind(pwr_cap,as.data.frame(tmplist[[i]][2]))
            pwr_ncap = rbind(pwr_ncap,as.data.frame(tmplist[[i]][3]))
            pwr_flows = rbind(pwr_flows,as.data.frame(tmplist[[i]][4]))
            pwr_costs = rbind(pwr_costs,as.data.frame(tmplist[[i]][5]))
          
            tradf = rbind(tradf,as.data.frame(tmplist[[i]][6]))
            tra_flows = rbind(tra_flows,as.data.frame(tmplist[[i]][18]))
            tra_costs = rbind(tra_costs,as.data.frame(tmplist[[i]][19]))
            tra_cap = rbind(tra_cap,as.data.frame(tmplist[[i]][20]))
            tra_ncap = rbind(tra_ncap,as.data.frame(tmplist[[i]][21]))
            
            clpricesdf = rbind(clpricesdf, as.data.frame(tmplist[[i]][7]))
            
            varactdf = rbind(varactdf, as.data.frame(tmplist[[i]][8]))
            
            inddf = rbind(inddf,as.data.frame(tmplist[[i]][9]))
            ind_flows = rbind(ind_flows,as.data.frame(tmplist[[i]][10]))
            ind_costs = rbind(ind_costs,as.data.frame(tmplist[[i]][11]))
            
            resdf = rbind(resdf,as.data.frame(tmplist[[i]][12]))
            res_flows = rbind(res_flows,as.data.frame(tmplist[[i]][13]))
            res_cost = rbind(res_cost,as.data.frame(tmplist[[i]][14]))
            
            comdf = rbind(comdf, as.data.frame(tmplist[[i]][15]))
            com_costs = rbind(com_costs,as.data.frame(tmplist[[i]][16]))
            com_flows = rbind(com_flows,as.data.frame(tmplist[[i]][17]))
            
            refs_flows = rbind(refs_flows,as.data.frame(tmplist[[i]][22]))
            refs_costs = rbind(refs_costs,as.data.frame(tmplist[[i]][23]))
            refs_cap = rbind(refs_cap,as.data.frame(tmplist[[i]][24]))
            refs_ncap = rbind(refs_ncap,as.data.frame(tmplist[[i]][25]))
            
            pwr_emis = rbind(pwr_emis,as.data.frame(tmplist[[i]][26]))
            ind_emis = rbind(ind_emis,as.data.frame(tmplist[[i]][27]))
            res_emis = rbind(res_emis,as.data.frame(tmplist[[i]][28]))
            com_emis = rbind(com_emis,as.data.frame(tmplist[[i]][29]))
            tra_emis = rbind(tra_emis,as.data.frame(tmplist[[i]][30]))
            sup_emis = rbind(sup_emis,as.data.frame(tmplist[[i]][31]))
            refs_emis = rbind(refs_emis,as.data.frame(tmplist[[i]][32]))
            all_emis = rbind(all_emis,as.data.frame(tmplist[[i]][33]))
            pwr_indicators = rbind(pwr_indicators,as.data.frame(tmplist[[i]][1])) #note that i have started using up the old indexes which are not used in the new ShinyAPP
            EB = rbind(EB,as.data.frame(tmplist[[i]][34]))
            Sys.sleep(0.1)
            }
            })
    
    #now assign the newly read in dataframes to reactive variables
    variables$pwr_cap = pwr_cap
    variables$pwr_ncap = pwr_ncap
    variables$pwr_flows = pwr_flows
    variables$pwr_costs = pwr_costs
    variables$tradf = tradf
    variables$tra_flows = tra_flows
    variables$tra_costs = tra_costs
    variables$tra_cap = tra_cap
    variables$tra_ncap = tra_ncap
    variables$clpricesdf = clpricesdf
    variables$varactdf = varactdf
    variables$inddf = inddf
    variables$ind_flows = ind_flows
    variables$ind_costs = ind_costs
    variables$resdf = resdf
    variables$res_flows = res_flows
    variables$res_cost = res_cost
    variables$comdf = comdf
    variables$com_costs = com_costs
    variables$com_flows = com_flows
    variables$refs_flows = refs_flows
    variables$refs_costs = refs_costs
    variables$refs_cap = refs_cap
    variables$refs_ncap = refs_ncap
    variables$pwr_emis = pwr_emis
    variables$ind_emis = ind_emis
    variables$res_emis = res_emis
    variables$com_emis = com_emis
    variables$tra_emis = tra_emis
    variables$sup_emis = sup_emis
    variables$refs_emis = refs_emis
    variables$all_emis = all_emis
    variables$pwr_indicators = pwr_indicators
    variables$EB = EB
    
    casenames = unique(pwr_cap$Case)
    variables$myinclusion = sort(casenames)[1]
    updateTabsetPanel(session,'powertabs',selected = 'totalcapacity')#switch the user to the first results panel
  })
  #END OF READING IN DATAFRAMES INTO THE ENVIRONMENT
  
  
  #POWER TABS ============================================
  output$pwr_cappivottable <- renderRpivotTable({
    rpivotTable(
      variables$pwr_cap,
      rows= 'Subsector',
      col = mycollist,
      aggregatorName= 'Sum',
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'Capacity',
      rendererName = 'Stacked Bar Chart'
    )
  })
    
  output$pwr_ncappivottable <- renderRpivotTable({
    rpivotTable(
      variables$pwr_ncap,
      rows=myrowlist,
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'NCAPL',
      rendererName = 'Stacked Bar Chart'
    )
      })
  
  output$pwr_flowspivottable <- renderRpivotTable({
    rpivotTable(
      variables$pwr_flows,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals='F_IN',
      rendererName = deflt_view
    )
  })
  
  output$pwr_costspivottable <- renderRpivotTable({
    rpivotTable(
      variables$pwr_costs,
      rows=c('Subsector','Subsubsector'),
      col = mycollist,
      aggregatorName= 'Sum',
      inclusions = list(Case = list(variables$myinclusion)),
      vals='CST_INVC',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  output$ele_indicatorspivottable <- renderRpivotTable({
    rpivotTable(
      variables$pwr_indicators,
      rows = 'Case',
      col = 'Year',
      aggregatorName = 'Sum',
      vals = 'Elec_price_RpkWh',
      rendererName = 'Line Chart'
    )
  })
  
  output$pwremispivottable <- renderRpivotTable({
    rpivotTable(
      variables$pwr_emis,
      rows='Emissions',
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(variables$myinclusion)),
      vals='GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  #========================================================
  
  output$refemispivottable <- renderRpivotTable({
    rpivotTable(
      variables$refs_emis,
      rows='Emissions',
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(variables$myinclusion)),
      vals='GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  #RESIDENTIAL ==================================
  output$resfpivottable <- renderRpivotTable({
    rpivotTable(
      variables$res_flows,
      rows=c('Subsector','Subsubsector'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals='F_IN',
      rendererName = deflt_view
    )
  })
  
  output$rescpivottable <- renderRpivotTable({
    rpivotTable(
      variables$res_cost,
      rows= c('Subsector','Subsubsector'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals='Allcosts',
      rendererName = deflt_view
    )
  })
  
  output$resemispivottable <- renderRpivotTable({
    rpivotTable(
      variables$res_emis,
      rows=c('Emissions_source'),
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(variables$myinclusion)),
      vals='GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  #   ============================
  
  output$pwrpivottable <- renderRpivotTable({
    rpivotTable(
      variables$pwrdf,
      rows=myrowlist,
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals=deflt_vals,
      rendererName = deflt_view
    )
  })
  
  #INDUSTRy ================================
  output$indpivottable <- renderRpivotTable({
    rpivotTable(
      variables$inddf,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
    })
  
  output$indfpivottable <- renderRpivotTable({
    rpivotTable(
      variables$ind_flows,
      rows=c('Subsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
  })
  output$indcpivottable <- renderRpivotTable({
    rpivotTable(
      variables$ind_costs,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'Allcosts',
      rendererName = deflt_view
    )
  })
  
  output$indemispivottable <- renderRpivotTable({
    rpivotTable(
      variables$ind_emis,
      rows=c('Emissions_source'),
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(variables$myinclusion)),
      vals='GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
  })

  # TRANSPORT ===================================
  output$trapivottable <- renderRpivotTable({
    rpivotTable(
      variables$tradf,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
  })
  
  output$tracappivottable <- renderRpivotTable({
    rpivotTable(
      variables$tra_cap,
      rows=c('Subsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'Capacity',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  output$trafpivottable <- renderRpivotTable({
    rpivotTable(
      variables$tra_flows,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
    
  })
  output$tracpivottable <- renderRpivotTable({
    rpivotTable(
      variables$tra_costs,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'CST_INVC',
      rendererName = deflt_view
    )
  })
  
  output$trancappivottable <- renderRpivotTable({
    rpivotTable(
      variables$tra_ncap,
      rows=c('Subsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'NCAPL',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  output$traemispivottable <- renderRpivotTable({
    rpivotTable(
      variables$tra_emis,
      rows=c('Emissions'),
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(variables$myinclusion)),
      vals='GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  #REFINERIES =============================================
  output$refcappivottable <- renderRpivotTable({
    rpivotTable(
      variables$refs_cap,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'Capacity',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  output$reffpivottable <- renderRpivotTable({
    rpivotTable(
      variables$refs_flows,
      rows=c('Subsector','Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
  })
  
  output$refcpivottable <- renderRpivotTable({
    rpivotTable(
      variables$refs_costs,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'Allcosts',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  output$refncappivottable <- renderRpivotTable({
    rpivotTable(
      variables$refs_ncap,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'NCAPL',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  output$respivottable <- renderRpivotTable({
    rpivotTable(
      variables$resdf,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
  })
  
  output$compivottable <- renderRpivotTable({
    rpivotTable(
      variables$comdf,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
  })
  
  # COMMERCE =========================================
  output$comfpivottable <- renderRpivotTable({
    rpivotTable(
      variables$com_flows,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
  })
  
  output$comcpivottable <- renderRpivotTable({
    rpivotTable(
      variables$com_costs,
      rows=c('Subsubsector','Commodity_Name'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'F_IN',
      rendererName = deflt_view
    )
  })
  
  output$varpivottable <- renderRpivotTable({
    rpivotTable(
      variables$varactdf,
      rows=c('Case','Subsubsector'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'VAR_ACT',
      rendererName = deflt_view
    )
  })
  
  output$comemispivottable <- renderRpivotTable({
    rpivotTable(
      variables$com_emis,
      rows=c('Emissions'),
      col = mycollist,
      aggregatorName='Sum',
      inclusions = list(Case = list(variables$myinclusion)),
      vals='GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  output$allemispivottable <- renderRpivotTable({
    rpivotTable(
      variables$all_emis,
      rows=c('Sector'),
      col = mycollist,
      aggregatorName=deflt_aggr,
      inclusions = list(Case = list(variables$myinclusion)),
      vals= 'GHG_kt',
      rendererName = 'Stacked Bar Chart'
    )
  })
  
  output$EBpivottable <- renderRpivotTable({
    rpivotTable(
      variables$EB,
      rows=c('Sector'),
      col = 'Commodity_Name',
      aggregatorName=deflt_aggr,
      inclusions = list(Year = list('2006'),Case = list(variables$myinclusion)),
      vals= 'flow_PJ',
      rendererName = 'Table'
      )
      })
})

