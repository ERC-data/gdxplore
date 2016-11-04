# Set required variables
path <- getwd()

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

# Source requried files
source(paste(path, 'functions.R',sep='/')) #load the groupfiles function