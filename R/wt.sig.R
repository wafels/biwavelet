wt.sig <-
function (d, dt, scale, sig.test=0, sig.level=0.95, dof=2, lag1=NULL, 
          mother=c("morlet", "paul", "dog"), param=-1, sigma2=NULL) {
  
  mothers=c("morlet", "paul", "dog")
  mother=match.arg(tolower(mother), mothers)
  
  ## Find the AR1 coefficient
  if (is.null(dt) & NCOL(d) > 1) {
    dt = diff(d[, 1])[1]
    x = d[, 2] - mean(d[, 2])
  }
  else {
    x = d - mean(d)
  }
  
  if (is.null(lag1))
    lag1=arima(x, order=c(1, 0, 0))$coef[1]
  n1=NROW(d)
  J1=length(scale) - 1
  s0=min(scale)
  dj=log(scale[2] / scale[1]) / log(2)  
  if (is.null(sigma2))
    sigma2=var(x)
  types=c("morlet", "paul", "dog")
  mother=match.arg(tolower(mother), types)
    
  ## Get the appropriate parameters [see Table(2)]
  if (mother=='morlet') {
    if (param == -1)
      param = 6
    k0 = param
    fourier.factor = (4 * pi) / (k0 + sqrt(2 + k0^2))
    empir = c(2, -1, -1, -1)
    if (k0 == 6)
      empir[2:4] = c(0.776, 2.32, 0.60)
  }
  else if (mother == 'paul') {
    if (param == -1)
      param = 4
    m = param
    fourier.factor = 4 * pi/(2 * m + 1)
    empir = c(2, -1, -1, -1)
    if (m == 4)
      empir[2:4]=c(1.132, 1.17, 1.5)
  }
  else if (mother=='dog') {
    if (param == -1)
      param = 2
    m = param
    fourier.factor = 2 * pi * sqrt(2 / (2 * m + 1));
    empir = c(1, -1, -1, -1)
    if (m == 2)
      empir[2:4] = c(3.541, 1.43, 1.4)
    if (m == 6)
      empir[2:4] = c(1.966, 1.37, 0.97)
  }
  else
    stop("mother wavelet parameter must be 'morlet', 'paul', or 'dog'")
  
  period = scale * fourier.factor
  dofmin = empir[1]     ## Degrees of freedom with no smoothing
  Cdelta = empir[2]     ## reconstruction factor
  gamma.fac = empir[3]  ## time-decorrelation factor
  dj0 = empir[4]        ## scale-decorrelation factor
  freq = dt / period    ## normalized frequency
  
  fft.theor = (1 - lag1^2) / (1 - 2 * lag1 * cos(freq * 2 * pi) + lag1^2)
  fft.theor = sigma2 * fft.theor  ## include time-series variance
  signif = fft.theor
  if (dof == -1)
    dof = dofmin
  if (sig.test == 0) { ## no smoothing, DOF=dofmin
    dof = dofmin
    chisquare = qchisq(sig.level, dof) / dof
    signif = fft.theor * chisquare
  }
  else if (sig.test == 1)  { ## time-averaged significance
    if (length(dof) == 1)
      dof=rep(dof, J1 + 1)
    truncate = which(dof < 1)
    dof[truncate] = rep(1, length(truncate))
    dof = dofmin * sqrt(1 + (dof * dt / gamma.fac / scale)^2)
    truncate = which(dof < dofmin)
    dof[truncate] = dofmin * rep(1, length(truncate)) ## minimum DOF is dofmin
    
    for (a1 in seq(1, J1+1, 1)) {
      chisquare = qchisq(sig.level, dof[a1]) / dof[a1]
      signif[a1] = fft.theor[a1]*chisquare
    }
  }
  else if (sig.test == 2) { ## time-averaged significance
    if (length(dof) != 2)
      stop('DOF must be set to [S1,S2], the range of scale-averages')
    if (Cdelta == -1) {
      stop(paste('Cdelta & dj0 not defined for', mother, 'with param=', param))
    }
    s1 = dof[1]
    s2 = dof[2]
    avg = which((scale >= s1) & (scale <= s2)) ## scales between S1 & S2
    navg = length(avg)
    if (navg == 0)
      stop(paste("No valid scales between", s1, 'and', s2))
    Savg = 1 /sum(1 / scale[avg])
    Smid = exp((log(s1) + log(s2)) / 2) ## power-of-two midpoint
    dof = (dofmin * navg * Savg / Smid) * sqrt(1 + (navg * dj / dj0)^2)
    fft.theor = Savg * sum(fft.theor[avg] / scale[avg])
    chisquare = qchisq(sig.level, dof) / dof
    signif = (dj * dt / Cdelta / Savg) * fft.theor * chisquare
  }
  else
    stop('sig.test must be 0, 1, or 2')
  
    return (list(signif=signif, fft.theor=fft.theor))
}

