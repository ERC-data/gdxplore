#appending new results to existing results

library(reshape2)
library(gdxrrw) 
library(dplyr)
library(XLConnect)

newfilepath = 'alocation' #location of the new gdx to be processed and appended
existfilepath = '' #location of the existing processed results rds file

#main working directory for this file/script and colourcoding files etc. 
workdir = 'C:/Users/01425453/Google Drive/SATIM/R codes and outputs/SATIM General Outputs/'

GAMS_lib_dir = 'C:/GAMS/win64/24.7'  # location of your GAMS main directory. 

# connect to the GAMS library.
igdx(GAMS_lib_dir) 


#LOAD FUNCTIONS
source(paste(workdir,'extractResults_v5.R',sep =''))

#======================process and extract results from the new gdx
print('Processing gdx to append...')
newgdxresults = processGDX(newfilepath,newgdxname)


#======================get existing processed set of results and append new ones
print('reading in the existing processed results RDS file')
existrds = readRDS(existfilepath)

print('appending new processed result to existing one...')
if(newgdxname %in% names(existrds)){
  #make sure there is no scenario/gdxname in the existing file already
  msg = c("A scenario ",newgdxname,' ','already exists!!!')
  stop(msg)
  #####EXIT HERE
}else{
  #append new result
  newrds = existrds
  newrds[newgdxname] = newgdxresults
  print('done appending new result to rds')
}


