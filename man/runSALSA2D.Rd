% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/runSALSA2D.R
\name{runSALSA2D}
\alias{runSALSA2D}
\title{Running SALSA for a spatial smooth with a CReSS basis}
\usage{
runSALSA2D(
  model,
  salsa2dlist,
  d2k,
  k2k,
  splineParams = NULL,
  chooserad = FALSE,
  panels = NULL,
  suppress.printout = FALSE,
  tol = 0,
  plot = FALSE,
  basis = "gaussian",
  initialise = TRUE,
  initialKnots = NULL,
  initialKnPos = NULL
)
}
\arguments{
\item{model}{A model with no spatial smooth}

\item{salsa2dlist}{Vector of objects required for \code{runSALSA2D}: \code{fitnessMeasure}, \code{knotgrid}, \code{startKnots}, \code{minKnots}, code{maxKnots}, \code{r_seq}, \code{gap}, \code{interactionTerm}.}

\item{d2k}{(n x k) Matrix of distances between all data points in \code{model} and all valid knot locations specified in \code{knotgrid}}

\item{k2k}{(k x k) Matrix of distances between all valid knot locations specified in \code{knotgrid}}

\item{splineParams}{(default \code{=NULL}) List object containng output from runSALSA (e.g. knot locations for continuous covariates)}

\item{chooserad}{logical flag.  If FALSE (default) then the range parameter of the basis is chosen after the knot location and number. If TRUE, the range is assessed at every iteration of a knot move/add/drop.}

\item{panels}{Vector denoting the panel identifier for each data point (if robust standard errors are to be calculated). Defaults to data order index if not given.}

\item{suppress.printout}{(Default: \code{FALSE}. Logical stating whether to show the analysis printout.}

\item{tol}{Numeric stating the tolerance for the fitness Measure. e.g. tol=2 with AIC would only allow changes to be made if the AIC score improves by 2 units.}

\item{plot}{logical stating whether to print out the chosen knot locations at each iteration. \code{default = FALSE}.}

\item{basis}{One of 'gaussian' (default) or 'exponential'. Specifys what kind of local radial function to use (\code{\link{LRF.g}} or \code{\link{LRF.e}})}

\item{initialise}{(Defauls: \code{FALSE}). Logical stating whether to allow the \code{runSALSA2D} function to find some starting knot locations.  If \code{FALSE}, one of \code{initialKnots} or \code{initialKnPos} must be specified.}

\item{initialKnots}{c x 2 dataframe or matrix specifying the coordinates of the starting locations of knots. c is the number of initial knots (should match what is specified in \code{SALSA2dlist})}

\item{initialKnPos}{vector of length c denoting the rows of the \code{knotgrid} to use as the initial starting locations of knots.}
}
\value{
This function returns the best model \code{bestModel} and the fitness statistic for this model \code{fitStat}
The spline paramater object that is returned as part of the model object now contains a list in the first element (previously reserved for the spatial component).  This list contains the objects required for the SALSA2D fitting process:

\item{knotDist}{Matrix of knot to knot distances (k x k).  May be Euclidean or geodesic distances. Must be square and the same dimensions as \code{nrows(na.omit(knotgrid))}.  Created using \code{\link{makeDists}}.}
\item{radii}{Sequence of range parameters for the CReSS basis from local (small) to global (large).  Determines the range of the influence of each knot.}
\item{dist}{ Matrix of distances between data locations and knot locations (n x k). May be Euclidean or geodesic distances. Euclidean distances created using \code{\link{makeDists}}.}
\item{datacoords}{Coordinates of the data locations}
\item{response}{Vector of response data for the modelling process}
\item{knotgrid}{Grid of legal knot locations.}
\item{minKnots}{Minimum number of knots to be tried.}
\item{maxKnots}{Maximum number of knots to be tried.}
\item{gap}{Minimum gap between knots (in unit of measurement of \code{datacoords})}
\item{radiusIndices}{Vector of length startKnots identifying which radii (\code{splineParams[[1]]$radii}) will be used for each knot location (\code{splineParams[[1]]$knotPos})}
\item{knotPos}{Index of knot locations. The index identifies which knots (i.e. which rows) from \code{knotgrid} were selected by SALSA}
}
\description{
This function fits a spatially adaptive two dimensional smooth of spatial coordinates with knot number and location selected by SALSA.
}
\details{
The object \code{salsa2dlist} contains parameters for the \code{runSALSA2D} function.

   \code{fitnessMeasure}. The criterion for selecting the `best' model.  Available options: AIC, AIC_c, BIC, QIC_b, cv.gamMRSea (use cv.opts in salsa2dlist to specify seed, folds, cost function (Defaults: \code{cv.opts=list(cv.gamMRSea.seed=357, K=10, cost=function(y, yhat) mean((y - yhat)^2))})

   \code{knotgrid}. A set of 'k' knot locations (k x 2 matrix or dataframe of coordinates).  May be made using \code{\link{getKnotgrid}}.

   \code{startknots}. Starting number of knots (initialised as spaced filled locations).

   \code{minKnots}. Minimum number of knots to be tried.

   \code{maxKnots}. Maximum number of knots to be tried.

   \code{gap}. The minimum gap between knots (in unit of measurement of coordinates).
   \code{interactionTerm}. Specifies which term in \code{baseModel} the spatial smooth will interact with.  If \code{NULL} no interaction term is fitted.
   \code{cv.opts} Used if \code{fitnessMeasure = cv.gamMRSea}.  See above for specification.
}
\examples{
# load data
data(ns.data.re)
# load prediction data
data(ns.predict.data.re)
# load knot grid data
data(knotgrid.ns)

#set some input info for SALSA
ns.data.re$response<- ns.data.re$birds

# make distance matrices for datatoknots and knottoknots
distMats<-makeDists(cbind(ns.data.re$x.pos, ns.data.re$y.pos), na.omit(knotgrid.ns))

# set initial model without the spatial term
# (so all other non-spline terms)
initialModel<- glm(response ~ 1 + offset(log(area)),
                   family='quasipoisson', data=ns.data.re)

# make parameter set for running salsa2d
# I have chosen a gap parameter of 1000 (in metres) to speed up the process.
# Note that this means there cannot be two knots within 1000m of each other.

salsa2dlist<-list(fitnessMeasure = 'QICb', 
                  knotgrid = na.omit(knotgrid.ns),
                  startKnots = 6,
                  minKnots = 2, 
                  maxKnots = 20, 
                  gap=1000)

salsa2dOutput<-runSALSA2D(initialModel, 
                          salsa2dlist, 
                          d2k=distMats$dataDist,
                          k2k=distMats$knotDist)

}
\references{
Scott-Hayward, L.; M. Mackenzie, C.Donovan, C.Walker and E.Ashe.  Complex Region Spatial Smoother (CReSS). Journal of computational and Graphical Statistics. 2013. doi: 10.1080/10618600.2012.762920

Scott-Hayward, L.. Novel Methods for species distribution mapping including spatial models in complex regions: Chapter 5 for SALSA2D methods. PhD Thesis, University of St Andrews. 2013
}
\author{
Lindesay Scott-Hayward (University of St Andrews), Cameron Walker (University of Auckland)
}
