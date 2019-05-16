# Optimal cutpoints for linear model and 1 predictor

**Brief description**: Given a continous response (Y) and a continous predictor (X), this script provides the way to find the the optimal cutpoints that maximize the R<sup>2</sup>

**Note: Categorizing predictors is not a good practice at all. Continuous predictors should not be categorized. See, for example, the [TRIPOD guideline](https://annals.org/aim/fullarticle/2088542/transparent-reporting-multivariable-prediction-model-individual-prognosis-diagnosis-tripod-explanation). This material is for teaching purposes: what not to do**

# Files explanation

There are two files:

1. _**functions_rsquare_optim.R**_. It contains several functions to run an example.
    - *R_square_cat*. Return the R<sup>2</sup> for a set of given cutpoints
    - *ui_matrix*. Return the constraint matrix to run the function *constrOptim*
    - *ci_vector*. Return the vector matrix to run the function *constrOptim*
    - *theta_vector*. Return a vector of initial cutpoins to run the function *constrOptim*
2. _**example_rsquare_optim.R**_. It contains an implementation example


**These functions are not validated**
