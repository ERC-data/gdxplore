# loops over all rds files that the user has chosen and combines them for the viewer. 

groupfiles = function (rdslist){ #the character vec of rds files to group
  n = length(rdslist)
  newrds = list() # create blank empty main list that we will append results for viewing to. 
  
  for (i in seq(1,n)){#loop over each rds file and append it to newrds
    print(rdslist[i])
    newrdsfilename = paste(rdslist[i],'.rds',sep = '') #file name of the new results. example: 01REF.rds 
    newrdsfilepath= paste('C:/EMOD/RDSfiles',newrdsfilename,sep = '/')
    newgdxresults = readRDS(newrdsfilepath)
    newrdsname = rdslist[i] #give it the same name as the scenario
    newrds[newrdsname] = newgdxresults #append, and give it the same name as the scenario name
    
  } 
  print('saving RDS file')
  saverdspath = 'C:/EMOD/RDSfiles/grouped_scenarios.rds'
  saveRDS(newrds,saverdspath)

}
