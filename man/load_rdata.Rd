% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/load_rdata.R
\name{load_rdata}
\alias{load_rdata}
\title{\code{load_rdata}}
\usage{
load_rdata(fileName)
}
\arguments{
\item{fileName}{Name of the file to load.}
}
\value{
R object
}
\description{
Load processed data (\emph{.rda} format) using a function that assigns it
to a specific variable
(so you don't have to guess what the loaded variable name is).
}
\examples{
rda_url <- file.path("https://github.com/RajLabMSSM/echolocatoR",
                     "raw/master/data/BST1.rda")
out_path <- downloadR::downloader(input_url = rda_url,
                                  download_method = "axel")
BST1 <- downloadR::load_rdata(out_path)
}
