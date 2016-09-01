library(shiny)
library(rpivotTable)

rdsfilepath = "http://energydata.uct.ac.za/dataset/1db4d94d-867e-4706-a26e-b4600fee594b/resource/395efb75-30ae-4df1-b080-b7b3aabdb4fa/download/processedtestprojname24aug2016.rds"

tmplist = list()
pwrdf = data.frame()
tradf = data.frame()
clpricesdf = data.frame()
varactdf = data.frame()
tmplist = readRDS(gzcon(url(rdsfilepath)))

print('Appending pivottable dataframe from each case...')
#now have a list of lists - one list for each gdx
#now need to take each df out of each gdx list and append to masterdf's for each subsector
n = length(tmplist)
for (i in 1:n){
  print(i)
  pwrdf = rbind(pwrdf,as.data.frame(tmplist[[i]][1]))
  tradf = rbind(tradf,as.data.frame(tmplist[[i]][2]))
  clpricesdf = rbind(clpricesdf, as.data.frame(tmplist[[i]][3]))
  varactdf = rbind(varactdf, as.data.frame(tmplist[[i]][4]))
  #comdf = rbind(comdf, as.data.frame(tmplist[[i]][4]))
}


myrowlist = c('Subsubsector')
mycollist = c('Year')
deflt_aggr = 'Sum'
deflt_vals = 'Capacity'
deflt_view = 'Heatmap'

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
      vals= 'avgCLpriceAll',
      rendererName = 'Line Chart'
    )
    
  })
})