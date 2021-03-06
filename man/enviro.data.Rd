\name{enviro.data}
\alias{enviro.data}
\docType{data}
\title{
Multivariate ENSO (MEI), NPGO, and PDO indices
}
\description{
Monthly indices of ENSO, NPGO, and PDO from 1950 to 2009
}
\usage{data (enviro.data)}
\format{
  A data frame with 720 observations on the following 6 variables.
  \describe{
    \item{\code{month}}{a numeric vector containing the month}
    \item{\code{year}}{a numeric vector containing the year}
    \item{\code{date}}{a numeric vecor containing the date}
    \item{\code{mei}}{a numeric vector containing the MEI index}
    \item{\code{npgo}}{a numeric vector containing the NPGO index}
    \item{\code{pdo}}{a numeric vector containing the PDO index}
  }
}

\source{
MEI: \url{http://www.esrl.noaa.gov/psd/enso/mei}

NPGO: \url{http://www.o3d.org/npgo}

PDO: \url{http://jisao.washington.edu/pdo}
}
\references{
Di Lorenzo, E., N. Schneider, K. M. Cobb, P. J. S. Franks, K. Chhak, A. J. Miller, 
J. C. McWilliams, S. J. Bograd, H. Arango, E. Curchitser, T. M. Powell, and 
P. Riviere. 2008. North Pacific Gyre Oscillation links ocean climate and 
ecosystem change. \emph{Geophys. Res. Lett.} 35:L08607.

Mantua, N. J., and S. R. Hare. 2002. The Pacific decadal oscillation. 
\emph{Journal of Oceanography} 58:35-44.

Zhang, Y., J. M. Wallace, and D. S. Battisti. 1997. ENSO-like interdecadal 
variability: 1900-93. \emph{Journal of Climate} 10:1004-1020.
}
\examples{
data(enviro.data)
head(enviro.data)
}
\keyword{datasets}
