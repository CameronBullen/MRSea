# MRSea 1.3.3.001


## Notes
* SALSA1D:
  
* SALSA2D:

* Other:

  
## Bug Fixes

* SALSA 1D:

* SALSA 2D:

* Other:

  - convert data to data frame (not tibble) in `create.bootstrap.data` and `plotCumRes` functions


# MRSea 1.3.3


## Notes
* SALSA1D:

  - Update documentation for `runSALSA1D` to include `gap` parameter and `splines` parameter. Default settings are `gap=0` and `splines="bs"`.
  - Change specification of cyclic smooths (parameter now specified in `salsa1dlist`) and include additional option for a natural cubic spline.
  
* SALSA2D:

* Other:

  - Website created
  - Update to the vignettes included within the package and additional web only tutorials created.  Still under construction but included now is a basic usage vignette and information on the different splines. 
  - Add option for user specified label to plots in `runDiagnostics` function
  
## Bug Fixes

* SALSA 1D

 - Issue with using Q*IC and the update function for multiple 1D covariates. Problem resolved.

* SALSA 2D
  - Fix issue in initialise drop step when initial model has NA coefficients


# MRSea 1.3.2

## Notes
* Gap check added to initialise step to ensure gap parameter is obeyed during initialisation
* Remove storage of `models` object. Hang over from the early days of `MRSea` and taking up workspace memory.
* Update to the "Interaction" vignette to make it clearer and the two options of ways to include one. 
* Added an option to allow the user to specify their own sequence of radii. Use by adding `r_seq = ...` to `salsa2dlist`
 

## Bug Fixes

* CV fold bug fixed for SALSA1D. If correlated blocks specified, these were not maintained in the base model for use later in the algorithm. 
* reinstate `require(parallel)` in `do.bootstrap.cress.robust`


# MRSea 1.3.1

## Notes
* Package compiled using version of R >=4.0
* Removal of various now obsolete functions (predict.cress, getCVcress, getPvalues).  These have been superceded by (`predict.gamMRSea`, `cv.gamMRSea` and `anova.gamMRSea`)
* Updates to vignettes
 
## Bug Fixes

* Various fixes to comply with updated version of R

# MRSea 1.02


## Notes
* option added to runACF/plotacf functions to specify the the maximum lag to be plotted (maxlag=NULL).  This helps when there may be one long panel and you wish to see the detail in the smaller ones. 
* vignette updated
* drop step added to the initialise 2D step.  If the initial starting knots do not give a model that has converged then knots are dropped until convergence is achieved. Then the algorithm proceeds as normal (looping over exchange, improve, drop).
 
 
## Bug Fixes

* Fix to exchange step - error finding largest residual
* Fix issue clsandcov function which occurred when old factor levels remained in the panel variable (droplevels used to counter this)
* Fix issue in plotCumRes and runInfluence functions.  These work with gamMRSea type model now. 


# MRSea 1.01


## Notes

* Addition of an interaction term where the choice of knot locations for each level of the interaction are different.  Requires specialist set up of the knot grid and distance matrix.  These will be provided in a vignette shortly. 
* The user may also now specifiy which knots from the knotgrid they would like to use for initialising. See the help file for runSALSA2D for more. 

## Bug Fixes
  
* Fixed major bug in the improve step - issue with finding the nearest neighbours for a given knot.  


# MRSea 1.0-beta


## Notes

* Addition of GEODESIC distance calculation using the `makeDists` function. If you supply a polygon defining an exclusion area, geodesic distances are calculated. 
* Addition of cross-validation (cv.gamMRSea) as fitness measure
* Addition of option for gaussian (default) or exponential basis function (see runSALSA2D)
* Update to runPartialPlots function to allow inclusion (or not) of intercept uncertainty.
  
## Bug Fixes

* Fixed partial plot bug - issue with factor covariates which are characters.  This class now allowed.
  

# MRSea 0.99-beta


## Notes

* Major overhaul of package to include a new model class `gamMRSea`.
* Update to summary function to allow robust standard errors to be presented and used for hypothesis testing
* knotgrid for 2D smooth no longer required to be a regular grid
* calculation of basis radii absorbed into `runSALSA2D` function.
* predict.gamMRSea function call updated to have same names as predict.glm
* new cv.gamMRSea function.  This is the cv.glm function from the boot library edited to allow for use with gamMRSea models.

## Bug Fixes

* Fixed bug in summary and anova functions; term names now correct.
* `tol` option in runSALSA2D re-instated
