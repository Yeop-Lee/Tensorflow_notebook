## 160930
## Made by Dayoung Lee
## data rearrange for NN
## 1. arrange levels
## 2. value

## input data
te_data <- read.csv("5Act_Var_Te1_JH_Wifi_raw_complete.csv", header=FALSE)
tr_data <- read.csv("5Act_Var_Tr1_JH_Wifi_raw_complete.csv", header=FALSE)


## tr_ap_nlev : number of ap from training data
## te_ap_nlev : .. from testing data
## tr_ap_lev : list of ap from trining data
## te_ap_lev : list of ap from test data
## all_ap_nlev : totla number of ap from trining & testing data
## all_ap_lev : total list of ap from training & testing data

tr_ap_nlev <- nlevels(tr_data$V3)
tr_ap_lev <- levels(tr_data$V3)
te_ap_nlev <- nlevels(te_data$V3)
te_ap_lev <- levels(te_data$V3)
all_ap_nlev <- nlevels(factor(union(tr_data$V3,te_data$V3)))
all_ap_lev <- levels(factor(union(tr_data$V3,te_data$V3)))

max_length <- 0

## for loop for counting max length of sub_tr_data
## subset_tr_data : get one colume which is 4th having rssi value
for(i in 1:tr_ap_nlev){
  subset_tr_data <- tr_data[tr_data$V3==tr_ap_lev[i],4]
  max_length[i] <- length(subset_tr_data)
}

## for loop for binding subset_tr_data
for(i in 1:tr_ap_nlev){
  subset_tr_data <- tr_data[tr_data$V3==tr_ap_lev[i],4]
  print(length(subset_tr_data))

  if(i==1)
    total <- subset_tr_data
  else{
    length(subset_tr_data) <- max(max_length)
    total <- cbind(total,subset_tr_data)
  }
}

## give colnames
colnames(total) <- c(1:ncol(total))

## wirte total table to csv file
write.csv(total,file = "total.csv")


## extra information
## not use
tr_appear <- all_ap_lev %in% tr_ap_lev
te_appear <- all_ap_lev %in% te_ap_lev
table_appear <- data.frame(cbind(all_ap_lev,tr_appear,te_appear))
