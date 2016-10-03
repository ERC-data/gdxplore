#take newscenario.rds and append to existing_processed_scenarios.rds main list 

  #GET NAME OF RDS FILE FROM COMMAND PROMPT
  cmd_rdsname <- commandArgs(trailingOnly = TRUE) #this must be the file name eg: 01REF (without the .rds extension)
  newrdsname = cmd_rdsname[1]

rdsfileslocation = 'C:/EMOD/RDSfiles'
newrdsfilename = paste(newrdsname,'.rds',sep = '') #file name of the new results. example: 01REF.rds 

newrdsfilepath= paste(rdsfileslocation,newrdsfilename,sep = '/')

details = file.info(list.files(rdsfileslocation,pattern="*.rds"))
existfilename = rownames(details)[grepl('processed',rownames(details))] #get the most recent modified grouped results rds file to append to
existfilelocation = paste(rdsfileslocation,existfilename,sep = '/')

if (file.exists(existfilelocation)){
  print('reading in the existing processed results RDS file')
  existrds = readRDS(existfilelocation)
}else{
  #if there isnt an rds file with 'processed' in the name in the path then make a blank list
  print('Creating blank rds file to append to.')
  existrds = list()
  existfilelocation = paste(existfilelocation,'scenarios_processed.rds',sep = '/')#file doesnt exist. so make up the new name to save to at the end
}


print('appending new processed result to existing one...')
  #note: this will overwrite results with the same name (ie replace an old REF01)
  
  newgdxresults = readRDS(newrdsfilepath)
  newrds = existrds
  newrds[[newrdsname]] = newgdxresults
  print('done appending new result to rds')


#saving
print('saving RDS file')
saverdspath = existfilelocation
saveRDS(newrds,saverdspath)
print('saving complete')


