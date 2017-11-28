# Install and load required packages
packages <- c('ckanr','SOAR','shiny','rpivotTable','rprojroot')
for (p in packages){
    if (p %in% rownames(installed.packages())){
        lapply(p, library, character.only = TRUE)
    } else {
        install.packages(p)
        lapply(p, library, character.only = TRUE)
    }
}

# Local variables
path <- getwd()
projhome <- dirname(dirname(path))
rdsfileslocation <- paste(projhome, 'RDSfiles', sep='/')

# CKAN variables
#BMc 28 june 2017 - switched this off. its causes the app to crash
#ckanr_setup(url = 'http://energydata.uct.ac.za') # set the url to the CKAN data portal
#projectlist <- package_search('Model Outputs')$results # get a list of all projects with model outputs
projects <- ''#sapply(projectlist, '[[', 'organization')['title',]

# Source requried files
source(paste(path, 'functions.R', sep='/')) # load the functions.R

