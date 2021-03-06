\name{pwtc}
\alias{pwtc}
\title{
Compute partial wavelet coherence
}
\description{
Compute partial wavelet coherence between \code{y} and \code{x1} by partialling 
out the effect of \code{x2}
}
\usage{
pwtc (y, x1, x2, pad = TRUE, dj = 1/12, s0 = 2 * dt, J1 = NULL, 
     max.scale = NULL, mother = c("morlet", "paul", "dog"), param = -1, 
     lag1 = NULL, sig.level = 0.95, sig.test = 0, nrands = 300, quiet = FALSE)
}
\arguments{
  \item{y}{
time series y in matrix format (\code{n} rows x 2 columns). The first column 
  should contain the time steps and the second column should contain the values.
}
  \item{x1}{
time series x1 in matrix format (\code{n} rows x 2 columns). The first column 
  should contain the time steps and the second column should contain the values.
}
  \item{x2}{
time series x2 whose effects should be partialled out in matrix format (\code{n} rows x 2 columns). 
The first column should contain the time steps and the second column should contain the values.
}

\item{pad}{
pad the values will with zeros to increase the speed of the transform. Default is TRUE.
}
  \item{dj}{
spacing between successive scales. Default is 1/12.
}
  \item{s0}{
smallest scale of the wavelet. Default is \code{2*dt}.
}
  \item{J1}{
number of scales - 1.
}
  \item{max.scale}{
maximum scale. Computed automatically if left unspecified.
}
  \item{mother}{
type of mother wavelet function to use. Can be set to \code{morlet}, \code{dog}, 
or \code{paul}. Default is \code{morlet}. Significance testing is only available
for \code{morlet} wavelet.
}
  \item{param}{
nondimensional parameter specific to the wavelet function.
}
  \item{lag1}{
vector containing the AR(1) coefficient of each time series.
}
  \item{sig.level}{
significance level. Default is \code{0.95}.
}
  \item{sig.test}{
type of significance test. If set to 0, use a regular \eqn{\chi^2} test. 
If set to 1, then perform a time-average test. If set to 2, then do a scale-average
test.
}
  \item{nrands}{
number of Monte Carlo randomizations. Default is 300.
}

\item{quiet}{ Do not display progress bar. Default is \code{FALSE} }

}
\value{
Return a \code{biwavelet} object containing:

\item{coi }{matrix containg cone of influence}
\item{wave }{matrix containing the cross-wavelet transform of y and x1}
\item{rsq }{matrix of partial wavelet coherence between y and x1 (with x2 partialled out)}
\item{phase }{matrix of phases between y and x1}
\item{period }{vector of periods}
\item{scale }{vector of scales}
\item{dt }{length of a time step}
\item{t }{vector of times}
\item{xaxis }{vector of values used to plot xaxis}
\item{s0 }{smallest scale of the wavelet }
\item{dj }{spacing between successive scales}
\item{y.sigma }{standard deviation of y}
\item{x1.sigma }{standard deviation of x1}
\item{mother }{mother wavelet used}
\item{type }{type of \code{biwavelet} object created (\code{pwtc})}
\item{signif }{matrix containg \code{sig.level} percentiles of wavelet coherence
based on the Monte Carlo AR(1) time series}
}

\references{

Aguiar-Conraria, L., and M. J. Soares. 2013. The Continuous Wavelet Transform: 
moving beyond uni- and bivariate analysis. 
\emph{Journal of Economic Surveys} In press.

Cazelles, B., M. Chavez, D. Berteaux, F. Menard, J. O. Vik, S. Jenouvrier, and 
N. C. Stenseth. 2008. Wavelet analysis of ecological time series. 
\emph{Oecologia} 156:287-304.

Grinsted, A., J. C. Moore, and S. Jevrejeva. 2004. Application of the cross 
wavelet transform and wavelet coherence to geophysical time series. 
\emph{Nonlinear Processes in Geophysics} 11:561-566.

Ng, E. K. W., and J. C. L. Chan. 2012. Geophysical applications of 
partial wavelet coherence and multiple wavelet coherence. 
\emph{Journal of Atmospheric and Oceanic Technology} 29:1845-1853.

Torrence, C., and G. P. Compo. 1998. A Practical Guide to Wavelet Analysis. 
\emph{Bulletin of the American Meteorological Society} 79:61-78.

Torrence, C., and P. J. Webster. 1998. The annual cycle of persistence in the 
El Nino/Southern Oscillation. 
\emph{Quarterly Journal of the Royal Meteorological Society} 124:1985-2004.

}
\note{
The Monte Carlo randomizations can be extremely slow for large datasets. 
For instance, 1000 randomizations of a dataset consisting of 1000 samples 
will take ~30 minutes on a 2.66 GHz dual-core Xeon processor.
}

\author{
Tarik C. Gouhier (tarik.gouhier@gmail.com)

Code based on WTC MATLAB package written by Aslak Grinsted.
}

\examples{
y=cbind(1:100, rnorm(100))
x1=cbind(1:100, rnorm(100))
x2=cbind(1:100, rnorm(100))
## Partial wavelet coherence of y and x1
pwtc.yx1=pwtc(y, x1, x2, nrands=0)
## Partial wavelet coherence of y and x2
pwtc.yx2=pwtc(y, x2, x1, nrands=0)
## Plot partial wavelet coherence and phase difference (arrows)
## Make room to the right for the color bar
par(mfrow=c(2,1), oma=c(4, 0, 0, 1), mar=c(1, 4, 4, 5), mgp = c(1.5, 0.5, 0))
plot(pwtc.yx1, xlab="", plot.cb=TRUE, main="Partial wavelet coherence of y and x1 | x2")
plot(pwtc.yx2, plot.cb=TRUE, main="Partial wavelet coherence of y and x2 | x1")
}
