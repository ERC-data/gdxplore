# Creates list of all data objects to be included in shiny's input selection. 
rdslist <- function (dataset = NULL, directory = rdsfileslocation) {
    # Local implementation
    if(is.null(dataset)){
        details <- file.info(list.files(directory, pattern="*.rds")) # get list of all rds files 
        details <- details[with(details, order(as.POSIXct(mtime))), ] # order by last modified
        r <- rownames(details)[!(grepl('grouped',rownames(details)))] # get all rds files which are do not have 'processed' in the name ie - only scenarios. 
        r <- toupper(gsub('\\..*', '', r, ignore.case = TRUE)) # remove the .rds extension from file name and make capital
        return(r)
        
        # CKAN implementation     
    } else {
        r <- package_show(dataset, as = 'table')$resources$name
        #r <- toupper(gsub('[.]*', '', r, ignore.case = TRUE)) # remove the .rds extension from file name and make capital
        return(r)
    }
}

# Combines user's input selection into a single cached object. 
groupfiles <- function (x, dataset = NULL, directory = rdsfileslocation){ # the character vec of rds files to group
    newrds <- list() # create blank empty main list that we will append results for viewing to. 
    
    # Local implementation
    if (is.null(dataset)){
        for (i in seq(1, length(x))){ # loop over each rds file and append it to newrds
            print(x[i])
            rdspath <- paste(directory, paste0(x[i], '.rds'), sep = '/')
            newgdxresults <- readRDS(rdspath)
            newrdsname <- x[i] # give it the same name as the scenario
            newrds[newrdsname] <- newgdxresults # append, and give it the same name as the scenario name
            } 
    
    # CKAN implementation    
    } else {
        data <- package_show(dataset, as = 'table')$resources[c('name', 'url')]
        data_url <- data[data$name %in% x, 'url']
        
        # Read each resource from CKAN
        for (r in data_url){ 
            newgdxresults <- readRDS(gzcon(url(r)))
            newrds[r] <- newgdxresults # append, and give it the same name as the scenario name
        }
    }
    print('caching RDS file')
    Store(newrds)
}
