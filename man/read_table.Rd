% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_table.R
\name{read_table}
\alias{read_table}
\title{Read component from table-type H5 file}
\usage{
read_table(handle, data_product, component)
}
\arguments{
\item{handle}{\code{fdp} object}

\item{data_product}{a \code{string} specifying a data product}

\item{component}{a \code{string} specifying a data product component}
}
\value{
Returns a \code{data.frame} with attached \code{column_units}
attributes, if available
}
\description{
Function to read table type data from hdf5 file.
}
