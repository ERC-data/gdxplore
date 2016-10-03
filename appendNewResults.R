#take newscenario.rds and append to existing_processed_scenarios.rds main list 

  #GET NAME OF RDS FILE FROM COMMAND PROMPT
  cmd_rdsfile <- commandArgs(trailingOnly = TRUE) #this must be the file name eg: 01REF (without the .gdx extension)
  newrdsname = cmd_rdsfile[1]

rdsfileslocation = 'C:/EMOD/RDSfiles'
newrdsfilename = paste(newrdsname,'.rds',sep = '') #location of the new rds that will be appended to existing

newgdxname = newrdsname
newrdsfilepath= paste(rdsfileslocation,newrdsfilename,sep = '/')

details = file.info(list.files(rdsfileslocation,pattern="*.rds"))
rdsfilename = rownames(details)[grepl('processed',rownames(details))] #get the most recent modified grouped results rds file to append to

existfilepath = rdsfilepath #location of the existing processed results rds file

if (!file.exists(existfilepath)){
  #if there isnt an rds file in the path then make a blank list 
  print('Creating blank rds file to append to.')
  existrds = list()
}else{
  print('reading in the existing processed results RDS file')
  existrds = readRDS(existfilepath)
}


print('appending new processed result to existing one...')
  #note: this will overwrite results with the same name (ie replace an old REF01)
  
  newgdxresults = readRDS(newrdsfilepath)
  
  newrds = existrds
  newrds[[newgdxname]] = newgdxresults
  print('done appending new result to rds')


#saving
print('saving RDS file')
rdsname = paste(paste(projname,'processed',sep = '_'),dt,sep ='_')
saveRDS(newrds,paste(saverdspath,paste(rdsname,'.rds',sep = ''),sep=''))
print('saving complete')


