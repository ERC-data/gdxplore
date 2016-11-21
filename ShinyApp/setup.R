# Install and load required packages
library('ckanr')
library('SOAR')
library('shiny')
library('rpivotTable')
library('rprojroot')

# Local variables
path <- getwd()
projhome <- dirname(dirname(path))
rdsfileslocation <- paste(projhome, 'RDSfiles', sep='/')

# CKAN variables
ckanr_setup(url = 'http://energydata.uct.ac.za') # set the url to the CKAN data portal
projectlist <- package_search('Model Outputs')$results # get a list of all projects with model outputs
projects <- sapply(projectlist, '[[', 'organization')['title',]

# Source requried files
source(paste(path, 'functions.R', sep='/')) # load the functions.R

