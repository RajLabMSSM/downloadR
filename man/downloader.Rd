% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/downloader.R
\name{downloader}
\alias{downloader}
\title{downloader wrapper}
\usage{
downloader(
  input_url,
  output_dir = tempdir(),
  output_path = file.path(output_dir, basename(input_url)),
  download_method = c("axel", "wget", "download.file", "internal", "wininet", "libcurl",
    "curl"),
  retry_method = "download.file",
  background = FALSE,
  force_overwrite = FALSE,
  quiet = TRUE,
  show_progress = TRUE,
  continue = TRUE,
  alternate = TRUE,
  check_certificates = TRUE,
  timeout = 5 * 60,
  conda_env = "echoR_mini",
  nThread = 1,
  verbose = TRUE
)
}
\arguments{
\item{input_url}{URL to remote file.}

\item{output_dir}{The file directory you want to save the download in.}

\item{output_path}{The file name you want to save the download as.}

\item{download_method}{\itemize{
\item{\code{"axel"} : }{Multi-threaded}
\item{\code{"wget"} : }{Single-threaded}
\item{\code{"download.file"} : }{Single-threaded}
\item{\code{"internal"} : }{Single-threaded 
(passed to \link[utils]{download.file})}
\item{\code{"wininet"} : }{Single-threaded 
(passed to \link[utils]{download.file})}
\item{\code{"libcurl"} : }{Single-threaded 
(passed to \link[utils]{download.file})}
\item{\code{"curl"} : }{Single-threaded 
(passed to \link[utils]{download.file})}
}}

\item{retry_method}{Method to automatically 
retry with when the selected \code{download_method} fails.}

\item{background}{Run in background}

\item{force_overwrite}{Overwrite existing file.}

\item{quiet}{Run quietly.}

\item{show_progress}{show_progress.}

\item{continue}{continue.}

\item{alternate}{alternate,}

\item{check_certificates}{check_certificates}

\item{timeout}{How many seconds before giving up on download.
Passed to \code{download.file}. Default: \code{30*60} (30min).}

\item{conda_env}{Conda environment to use.}

\item{nThread}{Number of threads to parallelize over.}

\item{verbose}{Print messages.}
}
\value{
Local path to downloaded file.

Named vector of files, where the names are the URLs and the values 
are the paths to the respective local files.
}
\description{
R wrapper for \code{"axel"} (multi-threaded) and
 \code{"download.file"} (single-threaded) download functions.
}
\examples{
input_url <- paste(
    "https://github.com/RajLabMSSM/Fine_Mapping",
    "raw/master/Data/lead.SNP.coords.csv", sep="/")
output_paths <- downloadR::downloader(input_url = input_url)
}
\seealso{
Other downloaders: 
\code{\link{aws}()},
\code{\link{axel}()},
\code{\link{wget}()}
}
\concept{downloaders}
