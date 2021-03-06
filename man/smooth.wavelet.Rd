\name{smooth.wavelet}
\alias{smooth.wavelet}
\title{
Smooth wavelet in both the time and scale domains
}
\description{
The time smoothing uses a filter given by the absolute value of the wavelet
function at each scale, normalized to have a total weight of unity, which is a 
Gaussian function for the Morlet wavelet. The scale smoothing is done with a 
boxcar function of width 0.6, which corresponds to the decorrelation scale of 
the Morlet wavelet.
}
\usage{
smooth.wavelet (wave, dt, dj, scale)
}
\arguments{
  \item{wave}{
wavelet coefficients
}
  \item{dt}{
size of time steps
}
  \item{dj}{
number of octaves per scale
}
  \item{scale}{
wavelet scales
}
}

\value{
Returns the smoothed wavelet.
}
\references{
Torrence, C., and P. J. Webster. 1998. The annual cycle of persistence in the 
El Nino/Southern Oscillation. 
\emph{Quarterly Journal of the Royal Meteorological Society} 124:1985-2004.
}
\author{
Tarik C. Gouhier (tarik.gouhier@gmail.com)

Code based on WTC MATLAB package written by Aslak Grinsted.
}

\note{
This function is used internally for computing wavelet coherence. It is only 
appropriate for the morlet wavelet.
}

\examples{
## Not run: smooth.wt1=smooth.wavelet(wave, dt, dj, scale)
}
