% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write_estimate.R
\name{write_estimate}
\alias{write_estimate}
\title{Write estimate-type TOML file}
\usage{
write_estimate(value, handle, data_product, component, description)
}
\arguments{
\item{value}{an object of class \code{numeric}}

\item{handle}{\code{fdp} object}

\item{data_product}{a \code{string} specifying the name of the data product}

\item{component}{a \code{string} specifying a location within the toml file}

\item{description}{a \code{string} describing the data product component}
}
\description{
Function to populate toml file with point-estimate type data. If a file
already exists at the specified location, an additional component will be
added.
}
\seealso{
Other write functions: 
\code{\link{write_array}()},
\code{\link{write_distribution}()},
\code{\link{write_table}()}
}
\concept{write functions}
