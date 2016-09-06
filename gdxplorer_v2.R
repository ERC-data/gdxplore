
library(shiny)
#this 

#CKAN: 
#rdsfilepath = "http://energydata.uct.ac.za/dataset/1db4d94d-867e-4706-a26e-b4600fee594b/resource/395efb75-30ae-4df1-b080-b7b3aabdb4fa/download/processedtestprojname24aug2016.rds"

#local:
rdsfilepath = 'C:/Users/01425453/Desktop/Student R layout/RDSfiles/student_3scens_processed_06Sep2016.rds'
#'C:/Users/01425453/Google Drive/SATIM/R codes and outputs/SATIM General Outputs/processed_TestProjname_24Aug2016.rds'

tmplist = list()
pwrdf = data.frame()
pwr1 = pwr2 = pwr3 = pwr4 = data.frame()

tradf = tra_flows = tra_costs = tra_cap = tra_ncap = data.frame()
refs_costs = refs_flows = refs_ncap = refs_cap = data.frame()

resdf = data.frame()
res_flows = data.frame()
res_cost = data.frame()

inddf = data.frame()
ind_costs = data.frame()
ind_flows =data.frame()

comdf  = data.frame()
com_costs = data.frame()
com_flows = data.frame()

clpricesdf = data.frame()
varactdf = data.frame()

#local 
tmplist = readRDS(rdsfilepath)

#CKAN
#tmplist = readRDS(gzcon(url(rdsfilepath)))

print('Appending pivottable dataframe from each case...')
#now have a list of lists - one list for each gdx
#now need to take each df out of each gdx list and append to masterdf's for each subsector
n = length(tmplist)
for (i in 1:n){
  print(i)
  pwrdf = rbind(pwrdf,as.data.frame(tmplist[[i]][1]))
  pwr1 = rbind(pwr1,as.data.frame(tmplist[[i]][2]))
  pwr2 = rbind(pwr2,as.data.frame(tmplist[[i]][3]))
  pwr3 = rbind(pwr3,as.data.frame(tmplist[[i]][4]))
  pwr4 = rbind(pwr4,as.data.frame(tmplist[[i]][5]))
  
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
  
}

#runApp(paste(getwd(),'/ShinyApp/',sep =''))

