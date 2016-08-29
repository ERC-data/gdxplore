
#17 Aug 2016
#This is the processing fucntion for gdx's and for use in the GDXplorer pivotable

addPRCmap <- function(db){
  #this function gets the mapPRC dataset from the csv file which should be in your workdir
  #and merges it with db
  print('Adding process mapping')
  mapPRC = read.csv(paste(workdir,'mapPRC.csv',sep =''))
  db = merge(db,mapPRC,all = FALSE)
  return(db)
}

addCOMmap <- function(db){
  #this function gets the mapPRC dataset from the csv file which should be in your workdir
  #and merges it with db
  print('Adding mapping for commodities')
  mapCOM = read.csv(paste(workdir,'mapCOM.csv',sep =''))
  db = merge(db,mapCOM,all = FALSE)
  return(db)
}

processGDX <- function(gdxPath,gdxname){
  
  print(paste('Reading in parameters from GDX'))
  
  #Read in Parameters-------------------------------
  
  #Case name
  #mruncase =rgdx.set(gdxPath,'MRUNCASE')
  myCase= gdxname #as.character(mruncase[mruncase$RUN == gdxname,2])
  print(paste('.......',paste(myCase,'.......',sep = ''),sep =''))
  
  #Capacity
  CAPL = rgdx.param(gdxPath,'PAR_CAPL')
  NCAPL = rgdx.param(gdxPath,'PAR_NCAPL')
  RESID = rgdx.param(gdxPath,'PRC_RESID')
  
  #Activity
  VARACT = rgdx.param(gdxPath,'VARACT')
  
  #flows
  F_IN = rgdx.param(gdxPath,'F_IN')
  F_OUT = rgdx.param(gdxPath,'F_OUT')
  
  #Costs
  CST_INVC = rgdx.param(gdxPath,'CST_INVC')
  CST_FIXC = rgdx.param(gdxPath,'CST_FIXC')
  CST_ACTC =rgdx.param(gdxPath,'CST_ACTC')
  
  LEVCOST = rgdx.param(gdxPath,'PAR_NCAPR')
  LEVCOST= LEVCOST[,-4] #Drop the 'LEVCOST' descriptor column
  
  FuelCOMBAL = rgdx.param(gdxPath,'PAR_COMBALEM')
  names(FuelCOMBAL) =c('Region','Year','Commodity','Timeslice','fuelCombal')
  FuelCOMBAL= FuelCOMBAL[FuelCOMBAL$Timeslice =='ANNUAL',]
  FuelCOMBAL= FuelCOMBAL[FuelCOMBAL$Timeslice =='ANNUAL',]
  FuelCOMBAL= FuelCOMBAL[,-4]
  
  #add names and remove redundant columns
  
  names(CAPL) = c('Region','Year','Process','CAPL')
  names(NCAPL) = c('Region','Year','Process','NCAPL')  
  names(RESID) = c('Region','Year','Process','RESID')
  names(VARACT) = c('Region','Year','Process','VAR_ACT')
  
  names(F_IN) = c('Region','V_Year','Year','Process','Commodity','Timeslice','F_IN')
  names(F_OUT) = c('Region','V_Year','Year','Process','Commodity','Timeslice','F_OUT')
  
  names(CST_ACTC) = c('Region','V_Year','Year','Process','CST_ACTC')
  names(CST_FIXC) = c('Region','V_Year','Year','Process','CST_FIXC')
  CST_INVC = CST_INVC[,c(-5)] # remove 'inv' column which appears to have no data
  names(CST_INVC) = c('Region','V_Year','Year','Process','CST_INVC')
  
  names(LEVCOST) = c('Region','Year','Process','LEVCOST')
  
  RESID = RESID[RESID$Year %in% unique(CAPL$Year),] #RESID has every year, not just milestone years, so extract all years that CAPL has.
  
  CST_INVC <- CST_INVC %>%
    group_by(Region,Process,Year)%>%
    summarise(CST_INVC = sum(CST_INVC)) 
  CST_ACTC <- CST_ACTC %>%
    group_by(Region,Process,Year)%>%
    summarise(CST_ACTC = sum(CST_ACTC))
  CST_FIXC <- CST_FIXC %>%
    group_by(Region,Process,Year)%>%
    summarise(CST_FIXC = sum(CST_FIXC))
  
  #sum over vintages:
  F_IN = F_IN%>%
    group_by(Region,Year,Process,Commodity,Timeslice)%>%
    summarise(F_IN = sum(F_IN))
  
  F_OUT = F_OUT%>%
    group_by(Region,Year,Process,Commodity,Timeslice)%>%
    summarise(F_OUT = sum(F_OUT))
  
  simDEMX = rgdx.param(gdxPath,'SIM_DEMX')# demand extracted from excel
  names(simDEMX) = c('Commodity','Year','Demand')
  
  print('...done reading in parameters')
  
  #--------------------------------------------------------------
  print('...Refining the parameters and process results')
  
  #add mapping 
  F_IN = addPRCmap(F_IN)
  F_IN = addCOMmap(F_IN)
  F_IN = droplevels(F_IN)
  
  CST_INVC = addPRCmap(CST_INVC)
  CST_FIXC = addPRCmap(CST_FIXC)
  CST_ACTC = addPRCmap(CST_ACTC)
  #Total capacity = RESID + CAPL
  CAP_T = merge(CAPL,RESID,all = TRUE) 
  CAP_T[is.na(CAP_T)] = 0
  
  #Capacity total
  CAP_T = CAP_T %>%
    group_by(Region,Year,Process) %>%
    summarise(Capacity = sum(CAPL,RESID))
  CAP_T = addPRCmap(CAP_T)
  
  if(0){#NEEDS FIXING
    #totalFinal = sum of all fuels over all sectors. one value for each year
    totalFinal <- F_IN[F_IN$Commodity_Name%in% fuels&F_IN$Sector != ''&F_IN$Commodity_Name !='',] %>%
      group_by(Region,Year,Commodity_Name)%>%
      summarise(totalFinal = sum(F_IN))
    
    #coalfinal. Note that this excludes exports (the supply sector)
    coalFinal = F_IN[F_IN$Commodity_Name == 'Coal'& !(F_IN$Sector %in% c('','Supply')),] %>%
      group_by(Region,Year)%>%
      summarise(CoalTotal = sum(F_IN))
    #coalsharefinal 
    coalShareFinal = coalFinal
    coalShareFinal$CoalShare = coalShareFinal$CoalTotal/totalFinal$totalFinal
    
    #gasfinal. Note that this excludes exports (the supply sector)
    gasFinal = F_IN[F_IN$Commodity_Name == 'GAS'& !(F_IN$Sector %in% c('','Supply')),] %>%
      group_by(Region,Year)%>%
      summarise(GasTotal = sum(F_IN))
    
    gasShareFinal = gasFinal
    gasShareFinal$GasShare = gasShareFinal$GasTotal/totalFinal$totalFinal
    
    #Fossil Share 
    fossilShareFinal = gasShareFinal
    fossilShareFinal$FossilShare = fossilShareFinal$GasShare + coalShareFinal$CoalShare
    fossilShareFinal = fossilShareFinal[,-c(3,4)]
    
  }
  
  #Average coal prices. NEEDS SIM inputs  
  print('Calculating Average coal prices')
  sim_fuelpx = rgdx.param(gdxPath,'SIM_FUELPX')#fuel price (input) for central basin
  names(sim_fuelpx) =c('Process','Year','FUELPX')
  
  fuelpcpwr_cb = readWorksheetFromFile(paste(workdir,'ProcessingSets.xlsx',sep =''), sheet ='fuelpcpwr_cb')
  fuelpcpwr_a =  readWorksheetFromFile(paste(workdir,'ProcessingSets.xlsx',sep =''), sheet ='fuelpcpwr_a')
  fuelpcpwr=  readWorksheetFromFile(paste(workdir,'ProcessingSets.xlsx',sep =''), sheet ='fuelpcpwr')
  
  sim_FuelPcPwrCB = sim_fuelpx[sim_fuelpx$Process %in% fuelpcpwr_cb$Process,]
  sim_FuelPcPwrA = sim_fuelpx[sim_fuelpx$Process %in%fuelpcpwr_a$Process,]
  sim_FuelPcPwr = sim_fuelpx[sim_fuelpx$Process %in%fuelpcpwr$Process,]
  
  avgcoalpriceCB = merge(VARACT,sim_FuelPcPwrCB) %>% 
    mutate(t_cost = VAR_ACT*FUELPX)
  avgcoalpriceCB = avgcoalpriceCB%>%
    group_by(Region,Year)  %>%
    summarise(t_act = sum(VAR_ACT),
              t_cost = sum(t_cost))
  avgcoalpriceCB = avgcoalpriceCB %>% mutate(avgCLpriceCB = t_cost/t_act)           
  avgcoalpriceCB = avgcoalpriceCB[,c(1,2,5)]
  
  avgcoalpriceA = merge(VARACT,sim_FuelPcPwrA) %>% 
    mutate(t_cost = VAR_ACT*FUELPX)
  avgcoalpriceA = avgcoalpriceA%>%
    group_by(Region,Year)  %>%
    summarise(t_act = sum(VAR_ACT),
              t_cost = sum(t_cost))
  avgcoalpriceA = avgcoalpriceA %>% mutate(avgCLpriceA = t_cost/t_act)   
  avgcoalpriceA = avgcoalpriceA[,c(1,2,5)]
  
  #all 
  avgcoalprice = merge(VARACT,sim_FuelPcPwr) %>% 
    mutate(t_cost = VAR_ACT*FUELPX)
  avgcoalprice = avgcoalprice%>%
    group_by(Region,Year)  %>%
    summarise(t_act = sum(VAR_ACT),
              t_cost = sum(t_cost))
  avgcoalprice = avgcoalprice %>% mutate(avgCLpriceAll = t_cost/t_act)   
  avgcoalprice = avgcoalprice[,c(1,2,5)]
  
  #Electricity price calculations 
  print('calculating electricity price')
  TCST_ELE = merge(CST_INVC,CST_ACTC,all = TRUE)
  TCST_ELE = merge(TCST_ELE,CST_FIXC,all = TRUE)
  TCST_ELE[is.na(TCST_ELE)] = 0
  TCST_ELE = TCST_ELE[TCST_ELE$Sector == 'Power',]
  TCST_ELE$AllCosts = TCST_ELE[,7]+TCST_ELE[,8]+TCST_ELE[,9]
  TCST_ELE = TCST_ELE %>%
    group_by(Region,Year)%>%
    summarise(tcst_ele = sum(AllCosts))
  
  
  #dedicated mines
  minclpwr =readWorksheetFromFile(paste(workdir,'ProcessingSets.xlsx',sep =''), sheet ='minclpwr')
  
  TCST_PWRCL = merge(CST_ACTC,merge(CST_FIXC,CST_INVC,all = TRUE),all = TRUE) 
  TCST_PWRCL = TCST_PWRCL[TCST_PWRCL$Process %in% minclpwr$Process,]
  TCST_PWRCL[is.na(TCST_PWRCL)] = 0
  TCST_PWRCL = TCST_PWRCL %>% 
    group_by(Region,Year) %>%
    summarise(tcst_pwrcl = sum(CST_ACTC,CST_FIXC,CST_INVC))
  
  
  #non dedicated mines
  mincldual = readWorksheetFromFile(paste(workdir,'ProcessingSets.xlsx',sep =''), sheet ='mincledual')
  
  TCST_PWRDUAL =  merge(CST_ACTC,merge(CST_FIXC,CST_INVC,all = TRUE),all = TRUE) 
  TCST_PWRDUAL = merge(TCST_PWRDUAL,VARACT,all.x = TRUE)
  TCST_PWRDUAL = TCST_PWRDUAL[TCST_PWRDUAL$Process %in%  mincldual$Process,]
  TCST_PWRDUAL[is.na(TCST_PWRDUAL)] = 0
  TCST_PWRDUAL = TCST_PWRDUAL %>% mutate(tcost = VAR_ACT*(CST_ACTC+CST_FIXC+CST_INVC))
  TCST_PWRDUAL = TCST_PWRDUAL %>%
    group_by(Region,Year,tcost) %>%
    summarise(vartotal = sum(VAR_ACT))
  TCST_PWRDUAL = TCST_PWRDUAL%>% mutate(tcst_pwrdual = tcost/vartotal)
  TCST_PWRDUAL = TCST_PWRDUAL %>%
    group_by(Region,Year) %>%
    summarise(tcst_pwrdual = sum(tcst_pwrdual))
  
  #non dedicated mines waterberg
  mincldual_a = readWorksheetFromFile(paste(workdir,'ProcessingSets.xlsx',sep =''), sheet ='mincldual_a')
  TCST_PWRDUAL_A =  merge(CST_ACTC,merge(CST_FIXC,CST_INVC,all = TRUE),all = TRUE) 
  TCST_PWRDUAL_A = merge(TCST_PWRDUAL_A,VARACT,all.x = TRUE)
  TCST_PWRDUAL_A = TCST_PWRDUAL_A[TCST_PWRDUAL_A$Process %in%  mincldual_a$Process,]
  TCST_PWRDUAL_A[is.na(TCST_PWRDUAL_A)] = 0
  
  tmp = merge(TCST_PWRDUAL_A[,c(2,3)],VARACT[VARACT$Process == 'XPWRCLE-A',],all.x = TRUE)# used for getting varact of XPWRCLE-A for next calculation 
  if(any( is.na(unique(tmp$Process)) ) ) {
    #no XPWRCLE-A in the model.
    #this catches the case where there is no XPRWCLE-A
    print('no XPWRCLE-A for PWRDUAL-A')
    tmp[is.na(tmp)] = 0
  }else{
    tmp$Process = unique(tmp$Process)[!(is.na(unique(tmp$Process)))]
    tmp[is.na(tmp)] = 0
  }
  
  TCST_PWRDUAL_A$Var_XPWR = tmp$VAR_ACT
  TCST_PWRDUAL_A = TCST_PWRDUAL_A %>% mutate(tcost = Var_XPWR*(CST_ACTC+CST_FIXC+CST_INVC))%>%
    group_by(Region,Year,tcost) %>%
    summarise(vartotal = sum(VAR_ACT))%>%
    mutate(tv = tcost/vartotal)%>%
    group_by(Region,Year)%>%
    summarise(tcst_pwrdual_a = sum(tv))
  
  #total coal costs
  TCST_PWRCL_T = TCST_PWRDUAL_A 
  TCST_PWRCL_T$tcst_pwrcl_t = TCST_PWRCL_T$tcst_pwrdual_a +TCST_PWRDUAL$tcst_pwrdual + TCST_PWRCL$tcst_pwrcl
  TCST_PWRCL_T = TCST_PWRCL_T[,-3]
  
  #TCST_PWROTH
  mfuelpwr = readWorksheetFromFile(paste(workdir,'ProcessingSets.xlsx',sep =''), sheet ='mfuelpwr')
  #take process activity from mfuelpwr and multiply with marginal in vcombalem that corresponds with that process
  TCST_PWROTH = merge(merge(mfuelpwr,VARACT),FuelCOMBAL)
  TCST_PWROTH = TCST_PWROTH %>% mutate(other_pwr_costs = VAR_ACT*fuelCombal)%>%
    group_by(Region,Year)%>%
    summarise(other_pwr_costs =sum(other_pwr_costs))
  
  #regulated elctricity price
  varact_pwr = addPRCmap(VARACT)
  varact_pwr = varact_pwr[varact_pwr$Sector == 'Power',]
  ERPRICE = merge(merge(TCST_PWROTH,merge(TCST_PWRCL_T,TCST_ELE,all = TRUE),all = TRUE),varact_pwr)
  ERPRICE[is.na(ERPRICE)] = 0
  ERPRICE = ERPRICE%>% mutate(t_pwrcost = (3.6/1000)*(tcst_pwrcl_t+tcst_ele+other_pwr_costs))%>%
    group_by(Region,Year,t_pwrcost)%>%
    summarise(t_pwract = sum(VAR_ACT))%>%
    mutate(ele_price = t_pwrcost/t_pwract)
  ERPRICE = ERPRICE[,c(1,2,5)]
  
  
  #TRANSPORT PROCESSING
  print('calculating transport results')
  #passenger
  
  passengerModes = readWorksheetFromFile(paste(workdir,'ProcessingSets.xlsx',sep =''), sheet ='PassengerModes')
  passengerkm = rgdx.param(gdxPath,'Passengerkm')#get the passenger km
  names(passengerkm) = c('Commodity','Year','bpkm') 
  
  #simDEMX_pass = simDEMX[simDEMX$Commodity %in% passengerModes,]
  
  passengerOccupancy = merge(passengerkm,simDEMX[simDEMX$Commodity %in% passengerModes$Commodity,])
  names(passengerOccupancy)[4] = 'bvkm'
  #names(passengerOccupancy)[1] = 'Transport_Commodity'
  passengerOccupancy$Occupancy = passengerOccupancy$bpkm/passengerOccupancy$bvkm
  
  #add FOUT
  passengerkmAll = merge(passengerOccupancy,F_OUT)#this will cut out all non-milestone years
  
  passengerkmAll = passengerkmAll[,!(names(passengerkmAll) %in% c('Timeslice'))]#drop the timeslice column
  passengerkmAll$bpkm_fout = passengerkmAll$Occupancy*passengerkmAll$F_OUT
  names(passengerkmAll)[1] = 'TRA_commodity'
  #add F_IN 
  passengerkmAll = merge(passengerkmAll,F_IN,by.x = c('Process','Year','Region'),by.y = c('Process','Year','Region'))
  passengerkmAll = passengerkmAll[,!(names(passengerkmAll) %in% c('Timeslice'))]#drop the timeslice column
  #add mapping
  passengerkmAll = addPRCmap(passengerkmAll)
  passengerkmAll = droplevels(passengerkmAll)
  
  #Freight
  freightModes = readWorksheetFromFile(paste(workdir,'ProcessingSets.xlsx',sep =''), sheet ='FreightModes')
  tonkm = rgdx.param(gdxPath,'Tonkm')
  
  names(tonkm) =c('Commodity','Year','btkm')
  
  freightLoad = merge(tonkm,simDEMX[simDEMX$Commodity %in% freightModes$Commodity,])
  names(freightLoad)[4] = 'bvkm'
  
  freightLoad = freightLoad%>% mutate(load = btkm/bvkm)
  
  tonkmAll = merge(freightLoad,F_OUT)
  tonkmAll = tonkmAll[,!(names(tonkmAll) %in% c('Timeslice'))]#drop the timeslice column
  tonkmAll$btkm_fout = tonkmAll$load*tonkmAll$F_OUT
  names(tonkmAll)[1] = 'TRA_commodity' # for distinguishing later in the pivottables
  #add FIN
  tonkmAll = merge(tonkmAll,F_IN,by.x = c('Process','Year','Region'),by.y = c('Process','Year','Region'))
  tonkmAll = tonkmAll[,!(names(tonkmAll) %in% c('Timeslice'))]#drop the timeslice column
  
  #add mapping
  tonkmAll = addPRCmap(tonkmAll)
  tonkmAll = droplevels(tonkmAll)
  
  
  #Combine relavant dataframes and lists
  print('Combining dataframes into relavent sections')
  #POWER SECTOR
  tmp = merge(CAP_T,NCAPL,all = TRUE)#add capacity
  #tmp = merge(tmp,F_IN,all.x = TRUE)#add flow in 
  tmp = merge(tmp,CST_INVC,all.x = TRUE)#add investments
  tmp = merge(tmp,ERPRICE)#add elec price
  tmp = addPRCmap(tmp)#add mapping
  tmp = tmp[tmp$Sector == 'Power',]
  tmp$Case = myCase
  pwrdf = droplevels(tmp)
  
  #TRANSPORT
  tmp = merge(tonkmAll,passengerkmAll,all = TRUE)
  #tmp = merge(tmp,F_IN,all.x = TRUE)
  tmp$Case = myCase
  #tmp = tmp[,-8]#Remove 'Timeslices' column which only has annual
  tradf = droplevels(tmp)
  
  #COAL PRICES
  tmp = merge(avgcoalprice,avgcoalpriceA,all = TRUE)
  tmp = merge(tmp,avgcoalpriceCB,all = TRUE)
  
  tmp$Case = myCase
  coalPrices = droplevels(tmp)
  
  #INDUSTRY
  
  #RESIDENTIAL
  
  #COMMERCIAL
  
  #OTHERS
  
  #CAP
  #VARACT
  VARACT$Case = myCase
  VARACT = droplevels(addPRCmap(VARACT))
  #TotalFinal
  
  #Combine into list:
  masterlist = list(pwrdf,tradf,coalPrices,VARACT)
  
  print('DONE PROCESSING!')
  return(masterlist)
}