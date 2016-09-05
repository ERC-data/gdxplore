#Bryce McCall
#Aug 2016
#this file will process multiple GDX files into one data list and save it 

library(reshape2)
library(gdxrrw) 
library(dplyr)
library(rpivotTable)
#library(data.table)
library(shiny)
library(XLConnect)

#set filepaths
#load existing processed dataset (no need to process anything)
# query if user wants to add anotehr gdx? 
#   Y - prompt user for files (fileselection) then:
#     run processing on this file + append to existing then:
# run GDXplorer shiny

projname = "student_3scens"

# location of your GAMS main directory. 
GAMS_lib_dir = 'C:/GAMS/win64/24.7' 

#main working directory for this file/script and colourcoding files etc. 
workdir = 'C:/Users/01425453/Documents/R/gdxplore/'

#the GDX files location
gdxLocation = 'C:/Users/01425453/Desktop/Student R layout/GDXfiles/'
saverdspath = 'C:/Users/01425453/Desktop/Student R layout/RDSfiles/'

#'C:/Users/01425453/Google Drive/SATIM/R codes and outputs/SATIM General Outputs/Transport/'
#'C:/AnswerTIMESv6/Gams_WrkTI-MC/Gamssave/'#'C:/Users/01425453/Desktop/SATM_TR_results/'#

# connect to the GAMS library.
igdx(GAMS_lib_dir) 

#LOAD FUNCTIONS
source(paste(workdir,'extractResults_v5.R',sep =''))


setwd(gdxLocation)
gdxlist=list.files(pattern=".gdx")#get list of all gdx's in the location

#go over each gdx name on the list, and compute the gdx summaries for each, appending to a main list
N = length(gdxlist) 
tmplist = list()

for (i in (1:N)){
  gdxPath = paste(gdxLocation,gdxlist[i],sep = '')
  listname = gdxlist[i]
  gdxname = substr(gdxlist[i],1,nchar(gdxlist[i])-4)
  
  tmplist[[listname]] = processGDX(gdxPath,gdxname)
  
  if(i ==N){
    print('saving RDS file')
    dt = format(Sys.time(), "%d%b%Y")
    rdsname = paste(paste(projname,'processed',sep = '_'),dt,sep ='_')
    saveRDS(tmplist,paste(saverdspath,paste(rdsname,'.rds',sep = ''),sep = ''))
    print('saving complete')
    
    #now have a list of lists - one list for each gdx
    #now need to take each df out of each gdx list and append to masterdf's for each subsector
    
  }
}