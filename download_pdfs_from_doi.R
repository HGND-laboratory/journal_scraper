# Define the function to download PDFs by DOI
download_pdfs_by_doi <- function(csv_file_path, output_folder, delay = 2) {
  # Read the CSV file
  doi_data <- read_csv(csv_file_path)
  
  # Ensure DOI column exists
  if (!"doi" %in% colnames(doi_data)) {
    stop("The CSV file does not contain a 'doi' column.")
  }
  
  # Ensure the output folder exists
  if (!dir.exists(output_folder)) {
    dir.create(output_folder)
  }
  
  # Loop through each DOI
  for (doi in doi_data$doi) {
    # Resolve DOI to get the URL
    doi_url <- paste0("https://doi.org/", doi)
    article_url <- NULL
    
    try({
      response <- request(doi_url) %>%
        req_user_agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101 Firefox/91.0") %>%
        req_perform()
      article_url <- resp_url(response)
    }, silent = TRUE)
    
    # If URL resolution failed, log the error and continue
    if (is.null(article_url)) {
      cat("Failed to resolve DOI:", doi, "\n")
      next
    }
    
    # Extract file name from DOI
    clean_doi <- gsub("[^a-zA-Z0-9]", "_", doi)
    file_name <- paste0(clean_doi, ".pdf")
    file_path <- file.path(output_folder, file_name)
    
    # Try to download the PDF
    download_success <- FALSE
    try({
      # Check if the article_url ends with .pdf
      if (grepl("\\.pdf$", article_url)) {
        request(article_url) %>%
          req_user_agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101 Firefox/91.0") %>%
          req_perform() %>%
          resp_body_raw() %>%
          writeBin(con = file_path)
        download_success <- TRUE
      } else {
        # Attempt to find a direct PDF link from the resolved URL
        page <- request(article_url) %>%
          req_user_agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101 Firefox/91.0") %>%
          req_perform() %>%
          resp_body_html()
        
        pdf_link <- page %>%
          html_nodes("a") %>%
          html_attr("href") %>%
          .[grepl("\\.pdf$", .)][1]
        
        if (!is.na(pdf_link)) {
          # Convert relative link to absolute link if necessary
          if (!grepl("^http", pdf_link)) {
            pdf_link <- url_absolute(pdf_link, article_url)
          }
          request(pdf_link) %>%
            req_user_agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101 Firefox/91.0") %>%
            req_perform() %>%
            resp_body_raw() %>%
            writeBin(con = file_path)
          download_success <- TRUE
        }
      }
    }, silent = TRUE)
    
    if (download_success) {
      cat("Downloaded article from DOI:", doi, "\nSaved as:", file_path, "\n\n")
    } else {
      cat("Failed to download article from DOI:", doi, "\n\n")
    }
    
    # Wait for a specified delay before the next request
    Sys.sleep(delay)
  }
}
