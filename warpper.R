#this script is a wrapper for all the functions to be added

#install all packages at once
packs<-c("readr", "dplyr","tidyr","pdftools","rvest","rentrez","httr2")
lapply(packs, require, character.only = TRUE)


# Example usage
csv_file_path <- "articles.csv"  # Corrected path
output_folder <- "Downloaded_Articles"  # Corrected path
download_pdfs_by_doi(csv_file_path, output_folder)