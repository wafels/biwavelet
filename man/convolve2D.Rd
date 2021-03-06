\name{convolve2D}
\alias{convolve2D}
\title{
Fast column-wise convolution of a matrix
}
\description{
Use the Fast Fourier Transform to perform convolutions between a sequence and each column of a matrix.
}
\usage{
convolve2D (x, y, conj = TRUE, type = c("circular", "open"))
}

\arguments{
  \item{x}{
M \code{x} n matrix.
}
  \item{y}{
numeric sequence of length N.
}
  \item{conj}{
logical; if \code{TRUE}, take the complex conjugate before back-transforming. 
Default is \code{TRUE} and used for usual convolution.
}
  \item{type}{
character; one of \code{circular}, \code{open} (beginning of word is ok). 
For \code{circular}, the two sequences are treated as circular, i.e., periodic.

For \code{open} and \code{filter}, the sequences are padded with zeros (from left and right) 
first; \code{filter} returns the middle sub-vector of open, namely, the result of 
running a weighted mean of \code{x} with weights \code{y}.
}
}
\details{
This is a corrupted version of convolve made by replacing fft with mvfft in a few places. 
It would be nice to submit this to the R Developers for inclusion.
}

\author{
Brandon Whitcher
}

\note{
This function was copied from \code{waveslim} to limit package dependencies.
}
