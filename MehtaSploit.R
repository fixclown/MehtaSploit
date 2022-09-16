#Libraries
#install.packages("readxl") We only need to install it once
#install.packages("tidyjson")
#install.packages("tidyverse")
#install.packages('writexl')
#install.packages('openxlsx')
library(openxlsx)
library(writexl)
library(tidyverse)
library(tidyjson)
library(readxl)


# *****Set the working directory before starting******

#Importing the excel file (Main audit log)
mainAuditLog = read.csv("Accounts_AuditLog_2021-12-31_2022-09-15.csv")

#Getting the audit column from the dataframe and then extracting the json values to form a new DF.
AuditData = data.frame(mainAuditLog$AuditData)
AuditData = AuditData %>% as.tbl_json(json.column = "mainAuditLog.AuditData") %>% spread_all
AuditData = as.data.frame(AuditData)
colNum = which(colnames(AuditData) == "OrganizationId")
AuditData = AuditData[,-colNum]


#Getting unique IP list 
uniqueIP = data.frame(uniqueIP = unique(AuditData$ClientIP))
colnames(uniqueIP) = "ip"
#Extracting unique IP list to csv
write.table(uniqueIP[1:100, ], "unique1.csv",  quote = FALSE, sep = ",", col.names = "ip", row.names = FALSE)

write.table(uniqueIP[101:200, ], "unique2.csv",  quote = FALSE, sep = ",", col.names = "ip", row.names = FALSE)

write.table(uniqueIP[201:251, ], "unique3.csv",  quote = FALSE, sep = ",", col.names = "ip", row.names = FALSE)


#Import malicious IP list from ipqualityscore
dfOne = read.csv("ipcheck1.csv")
dfTwo = read.csv("ipcheck2.csv")
dfThree = read.csv("ipcheck3.csv")
dfFour = read.csv("")

#Combining the results 
ipcheckresults = rbind(dfOne, dfTwo, dfThree)
rm(dfOne,dfTwo,dfThree) #Removing the older files to keep workspace clean

# ****Optional if you want to save the final IPQualityScore CSV file*****
write.csv(ipcheckresults, "IPQualityScoreAnalysis.csv")

#Getting results where fraud score is greater than 0
index = which(ipcheckresults$Fraud.Score > 0 | ipcheckresults$Country.Code != "AU" | ipcheckresults$VPN == "true")
ipcheckresults = ipcheckresults[index,]

#Getting the IP addresses with a large fraud score
maliciousIPs = data.frame(ipcheckresults$Lookup.IP)
colnames(maliciousIPs) = "maliciousIPs"

#Get filtering logs to only check for activities using the Fraud IPs
index = 1
for(i in 1:nrow(maliciousIPs)) {
  indexOne = which(AuditData$ClientIP == maliciousIPs$maliciousIPs[i])
  index = c(index, indexOne)
}
index = index[-1]
AuditDataMalicious = AuditData[index, ]
AuditDataMalicious = as.data.frame(AuditDataMalicious)
colNum = which(colnames(AuditDataMalicious) == "..JSON")
AuditDataMalicious = AuditDataMalicious[,-colNum]



#Getting unique list of operation names
operationNames = unique(AuditDataMalicious$Operation)

#Making excel workbook with different sheets as operations
maliciousAuditExcel = createWorkbook()
for(i in 1:length(operationNames)) {
  addWorksheet(maliciousAuditExcel, operationNames[i])
  operationDF = AuditDataMalicious %>% filter(Operation == operationNames[i])
  operationDF = operationDF[ , colSums(is.na(operationDF)) == 0]
  writeData(maliciousAuditExcel, operationNames[i], operationDF)
}
saveWorkbook(maliciousAuditExcel, "outputNEW.xlsx", overwrite = TRUE)

