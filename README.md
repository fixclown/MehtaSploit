# MehtaSploit
An R script to automate the process of conducting BECs by conducting all of the preprocessing with just a few clicks.

MehtaSploit Documentation and Guide

MethaSploit is a script written in R to help assist with Business Email Comprise (BEC) cases. The script takes in logs from Office365 and automates the pre-processing as well as filtering of data. 

It includes functionality like:
•	Analysing IP scores from IPQualityScore by automatically making a unique list of IPs from the logs provided (these IP addresses need to be manually uploaded to IPQS).
•	Filtering of logs using malicious IPs
•	Automation of parsing JSON data from Office 365 logs.

To run the script installation of R is needed and the recommended IDE is R-studio. Installation guides to both can be found here:
R installation: https://r-coder.com/install-r/
R studio installation:  https://www.rstudio.com/products/rstudio/download/
Some additional guides:
https://techvidvan.com/tutorials/install-r/
https://www.youtube.com/watch?v=_2sewGCA0y4

Once the installation of R and R-Studio is completed the MehtaSploit script can be downloaded from GitHub:
https://github.com/fixclown/MehtaSploit

The script uses 5 libraries and the documentation for those can be found through R-Studio. 

To use the script first set your working directory. This can be done by clicking the 3 dots (…) at the right-hand side of the screen. Once there open your working directory and then click the cog icon on the files tab in the right-hand side and select the option “Set as working directory”.

Then import your audit log into the variable mainAuditLog by adding the file name and location (if present in a different directory) into the double quotes. Currently we are using the file “Accounts_AuditLog_2021-12-31_2022-09-15.csv”. Once this is done you can run the script up to the “Extracting IP section”
 
From here you can take the exported CSV files upload them to IPQualityScore and then reimport them into R and run the other remaining half of the script. 
To run certain things in the script you can highlight the area you want to run and then execute by either pressing the Run button on the upper half of the screen or by pressing “CTRL + Enter”.

It is recommended that the script is run section by section to help understand what is happening with the logs at each section. The filtering section and the analysing of malicious IP section of the R script can be altered as preferred by the user’s liking. 

Once done with all the analysing the result can be exported into your current working directory in an excel workbook format with each email operation as a separate sheet to make analysing easier.
