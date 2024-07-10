#this script is a wrapper for all the functions to be added

#install all packages at once
packs<-c("readr", "dplyr","tidyr","pdftools","rvest","rentrez","httr2")
lapply(packs, require, character.only = TRUE)
