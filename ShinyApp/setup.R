packages = c('ckanr','SOAR','shiny','rpivotTable','rprojroot','kimisc')
for (p in packages){
  if (p %in% rownames(installed.packages())){
    lapply(p, library, character.only = TRUE)
  } else {
      install.packages(p)
      lapply(p, library, character.only = TRUE)
  }
}

path = dirname(thisfile_source())
setwd(path)
source('grouprdsfiles.R') #load the groupfiles function