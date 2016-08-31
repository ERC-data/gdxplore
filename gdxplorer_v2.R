
library(shiny)

#CKAN: 
rdsfilepath = "http://energydata.uct.ac.za/dataset/1db4d94d-867e-4706-a26e-b4600fee594b/resource/395efb75-30ae-4df1-b080-b7b3aabdb4fa/download/processedtestprojname24aug2016.rds"
#local:
#rdsfilepath = 'C:/Users/01425453/Google Drive/SATIM/R codes and outputs/SATIM General Outputs/processed_TestProjname_24Aug2016.rds'
#Bryce's comment...

N = length(gdxlist) 
tmplist = list()
pwrdf = data.frame()
tradf = data.frame()
clpricesdf = data.frame()
varactdf = data.frame()


#tmplist = readRDS(rdsfilepath)

#CKAN
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

runApp(paste(workdir,'/ShinyApp/',sep =''))

