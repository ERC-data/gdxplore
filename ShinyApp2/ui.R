#UI
library(shiny)
rdsfileslocation = 'C:/EMOD/RDSfiles/'

details = file.info(list.files(rdsfileslocation,pattern="*.rds"))#get list of all rds files 
details = details[with(details, order(as.POSIXct(mtime))), ]#order my last modified
rdslist = rownames(details)[!(grepl('processed',rownames(details)))] #get all rds files which are do not have 'processed' in the name ie - only scenarios. 
rdslist = gsub('.{4}$', '', rdslist)# remove the .rds extension from file name

fluidPage(sidebarPanel(
  selectizeInput('group', NULL, NULL, multiple = TRUE, choices= rdslist),actionButton("ViewNowButton",'View now')),
  verbatimTextOutput('row'),
  verbatimTextOutput('row2')
  
)