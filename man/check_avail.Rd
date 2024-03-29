% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_avail.R
\name{check_avail}
\alias{check_avail}
\title{Check tool availability}
\usage{
check_avail(tool, conda_env = "echoR_mini", verbose = TRUE)
}
\arguments{
\item{tool}{Tool name, or full path to tool executable.}

\item{conda_env}{Conda environments to search in. 
If \code{NULL} (default), will search all conda environments.}

\item{verbose}{Print messages.}
}
\description{
Check whether a tool is installed and usable from the command line 
by simply invoking its name. If not, will try to find an executable of 
the tool via the specified \code{conda_env}.
Finally, if no executable can be found, will simply return \code{NULL}.
}
\keyword{internal}
