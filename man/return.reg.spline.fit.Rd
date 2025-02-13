% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SALSA1DCode.R
\name{return.reg.spline.fit}
\alias{return.reg.spline.fit}
\title{Code for adaptively spacing knots for a given covariate.}
\usage{
return.reg.spline.fit(
  response,
  explanatory,
  degree,
  minKnots,
  maxKnots,
  startKnots,
  gap,
  winHalfWidth,
  fitnessMeasure = "BIC",
  maxIterations = 100,
  initialise = TRUE,
  initialKnots = NULL,
  baseModel = NULL,
  bd,
  spl,
  interactionTerm = interactionTerm,
  suppress.printout = FALSE,
  cv.opts,
  splineParams
)
}
\arguments{
\item{response}{vector of response data for the modelling process}

\item{explanatory}{vector of covariate to find knots for}

\item{degree}{degree of the spline to be used}

\item{minKnots}{minimum number of knots to fit}

\item{maxKnots}{maximum number of knots to fit}

\item{startKnots}{number of equally spaced knots to start with (between minKnots and maxKnots)}

\item{gap}{minimum gap between knots (in unit of measurement of \code{explanatory})}

\item{winHalfWidth}{Half-width of window used to calculate region with biggest average residual magnitude}

\item{fitnessMeasure}{(default=BIC). Measure used to evaluate the fit. Other options are AIC, AICc, BIC, QAIC, QAICc, QICb (Quasi-Likelihood Information Criterion with log(n) penalty)}

\item{maxIterations}{exchange/improve heuristic will terminate after \code{maxIterations} if still running}

\item{initialise}{(default = TRUE). Logical stating whether or not to start with equally spaced knots (TRUE) or user specified locations (FALSE)}

\item{initialKnots}{If \code{initialise=FALSE} then the start locations for the knots are specified in \code{initialKnots}}

\item{baseModel}{starting model for SALSA to use.  Must not contain the covariate in \code{explanatory}}

\item{bd}{the x-coordinate of the boundary knots of \code{explanatory}}

\item{spl}{"bs" uses b-spline, "cc" uses cyclic cubic, "ns" uses natural cubic spline for fitting smooth to \code{explanatory}}

\item{interactionTerm}{character stating the variable to use as an interaction}

\item{suppress.printout}{\code{default=FALSE}. If TRUE, progress is printed into the workspace. If FALSE, a .log file is created in the working directory.}

\item{cv.opts}{A list object containing options for \code{cv.gamMRSea}.}
}
\description{
Code for adaptively spacing knots for a given covariate.
}
\author{
Cameron Walker, Department of Engineering Science, University of Auckland, University of Auckland), Lindesay Scott-Hayward (University of St Andrews)
}
