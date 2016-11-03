packages = c('ckanr','SOAR','shiny','rpivotTable','rprojroot')
for (p in packages){
  if (p %in% rownames(installed.packages())){
    lapply(p, library, character.only = TRUE)
  } else {
      install.packages(p)
      lapply(p, library, character.only = TRUE)
  }
}

path = getwd()
source(paste(path, 'grouprdsfiles.R',sep='/')) #load the groupfiles function