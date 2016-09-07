# Making a sankey diagram - basic testing

library(networkD3)
flowin = F_IN[F_IN$Year == 2006&F_IN$Sector != ''&F_IN$Commodity_Name != ''&F_IN$Commodity_Name != 'Water',names(F_IN)%in% c('Sector','Commodity_Name','F_IN')]
flowin = flowin %>% group_by(Sector,Commodity_Name)%>%summarise(value = sum(F_IN))
flowin = droplevels(flowin)
tmp1 = as.data.frame(unique(flowin[,1]));names(tmp1) = 'name'
tmp2 = unique(flowin[,2]);names(tmp2) = 'name'

mynodes = rbind(tmp1,tmp2)
n = dim(mynodes)[1]
mynodes$nameid = seq(0,n-1)
mynodes$name = as.character(mynodes$name)

flowin = merge(flowin,mynodes,by.x = 'Sector',by.y = 'name')
names(flowin)[names(flowin) == 'nameid'] = 'target'
flowin = merge(flowin,mynodes,by.x = 'Commodity_Name',by.y = 'name')
names(flowin)[names(flowin) == 'nameid'] = 'source'

mylinks = flowin[,names(flowin)%in% c('source','target','value')]
mynodes = as.data.frame(mynodes$name)
names(mynodes) = 'name'
mynodes$name = as.character(mynodes$name)#why the fuck does R turn the character into a fucking factor???


sankeyNetwork(Links = mylinks, Nodes = mynodes, Source = "source",
              Target = "target", Value = "value", NodeID = "name",
              units = "TWh", fontSize = 12, nodeWidth = 30)

