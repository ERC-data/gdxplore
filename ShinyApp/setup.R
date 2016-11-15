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

# Set required variables
dataset <- NULL # For local use, keep as is. For online referencing replace NULL with your-ckan-dataset-id
path <- getwd()
projhome <- dirname(dirname(path))
rdsfileslocation <- paste(projhome, 'RDSfiles', sep='/')
ckanr_setup(url = 'http://energydata.uct.ac.za') # set the url to the CKAN data portal

# Source requried files
source(paste(path, 'functions.R', sep='/')) # load the functions.R
