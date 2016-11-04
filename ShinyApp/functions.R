# loops over all rds files that the user has chosen and combines them for the viewer. 

groupfiles = function (x){ #the character vec of rds files to group
  newrds = list() # create blank empty main list that we will append results for viewing to. 
  
  for (i in seq(1, length(x))){#loop over each rds file and append it to newrds
    print(x[i])
    newrdsfilename = paste(x[i],'.rds',sep = '') #file name of the new results. example: 01REF.rds 
    newrdsfilepath= paste('C:/EMOD/RDSfiles',newrdsfilename,sep = '/')
    newgdxresults = readRDS(newrdsfilepath)
    newrdsname = x[i] #give it the same name as the scenario
    newrds[newrdsname] = newgdxresults #append, and give it the same name as the scenario name
  } 
  print('caching RDS file')
  saverdspath = 'C:/EMOD/RDSfiles/grouped_scenarios.rds'
  saveRDS(newrds,saverdspath)
}

rdslist <- function (dataset) {
  # Specify generic project structure and file locations
  
  if(missing(dataset)){
      projhome <- dirname(dirname(path))
      rdsfileslocation <- paste(projhome, 'RDSfiles/',sep='/')
  
      details <- file.info(list.files(rdsfileslocation,pattern="*.rds"))#get list of all rds files 
      details <- details[with(details, order(as.POSIXct(mtime))), ]#order my last modified
      rdslist <- rownames(details)[!(grepl('grouped',rownames(details)))] #get all rds files which are do not have 'processed' in the name ie - only scenarios. 
      rdslist <- gsub('.{4}$', '', rdslist)# remove the .rds extension from file name
      return(rdslist)
      
  } else {
      ckanr_setup(url = 'http://energydata.uct.ac.za') #set the url to the CKAN data portal
      rdslist <- package_show(dataset, as = 'table')$resources
      return(rdslist)
  }
}