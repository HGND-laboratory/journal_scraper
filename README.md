# Journal Scraper

`journal scraper` is an R package designed to facilitate the downloading of PDF files from various academic journal sources. The package provides functions to download PDFs using PubMed ID, PMC ID, and DOI.

## Installation

You can install the development version of `journal scraper` from GitHub with:

```R
# Install devtools if you haven't already
install.packages("devtools")

# Install journal scraper package
devtools::install_github("yourusername/journal_scraper")
```

## Usage

### Load the Package

```R
library(journal.scraper)
```

### Functions

The `journal scraper` package includes the following main functions:

#### 1. `download_pdf_from_pubmed`

Downloads a PDF file using a PubMed ID.

**Usage:**

```R
download_pdf_from_pubmed(pubmed_id, destination)
```

**Arguments:**
- `pubmed_id`: A character string representing the PubMed ID of the article.
- `destination`: A character string specifying the path where the downloaded PDF should be saved.

**Example:**

```R
download_pdf_from_pubmed("30670877", "path/to/save/article.pdf")
```

#### 2. `download_pdf_from_pmc`

Downloads a PDF file using a PMC ID.

**Usage:**

```R
download_pdf_from_pmc(pmc_id, destination)
```

**Arguments:**
- `pmc_id`: A character string representing the PMC ID of the article.
- `destination`: A character string specifying the path where the downloaded PDF should be saved.

**Example:**

```R
download_pdf_from_pmc("PMC5176308", "path/to/save/article.pdf")
```

#### 3. `download_pdf_from_doi`

Downloads a PDF file using a DOI.

**Usage:**

```R
download_pdf_from_doi(doi, destination)
```

**Arguments:**
- `doi`: A character string representing the DOI of the article.
- `destination`: A character string specifying the path where the downloaded PDF should be saved.

**Example:**

```R
download_pdf_from_doi("10.1038/s41586-020-2649-2", "path/to/save/article.pdf")
```

## Contributing

Contributions to `journal scraper` are welcome! If you have any suggestions, bug reports, or feature requests, please open an issue or submit a pull request on GitHub.

## License

`journal scraper` is licensed under the MIT License. See the `LICENSE` file for more information.

## Contact

If you have any questions or need further assistance, please contact Kaalindi Misra at misra.kaalindi@hsr.it.
