library(ckanr) #for data portal
library(SOAR) #for caching

# loops over all rds files that the user has chosen and combines them for the viewer. 

groupfiles <- function (x, dataset){ #the character vec of rds files to group
  newrds <- list() # create blank empty main list that we will append results for viewing to. 
  
  rdslist <- package_show(dataset, as = 'table')$resources[c('name', 'url')]
  rdslisturl <- rdslist[rdslist$name %in% x, 'url']
  
  for (r in rdslisturl){ #read each resource from CKAN
      newgdxresults <- readRDS(gzcon(url(r)))
      newrds[r] <- newgdxresults #append, and give it the same name as the scenario name
    }
  
  print('caching RDS file')
  Store(newrds)
}
