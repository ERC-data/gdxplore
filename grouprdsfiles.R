# loops over all rds files that the user has chosen and combines them for the viewer. 

groupfiles = function (rdslist){ #the character vec of rds files to group
  n = length(rdslist)
  
  for (i in seq(1,n)){#loop over each rds file and append it
    
    appendRDSfile(rdslist[i])#this is from the appendNewResults.R script  
    
    
  } 

}