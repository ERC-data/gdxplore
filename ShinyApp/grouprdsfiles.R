library(ckanr) #for data portal
library(SOAR) #for caching

# loops over all rds files that the user has chosen and combines them for the viewer. 

groupfiles = function (rdslist){ #the character vec of rds files to group
  newrds = list() # create blank empty main list that we will append results for viewing to. 
  
  for (r in rdslist){ #read each resource from CKAN
      print(r)
      resource_url <- resource_search(q = paste('name:', r, sep=''), as = 'table')$results$url #ckanr API call
      newgdxresults <- readRDS(gzcon(url(resource_url)))
      newrds[r] = newgdxresults #append, and give it the same name as the scenario name
    }
  
  print('caching RDS file')
  Store(newrds)
}
