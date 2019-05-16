rm(list=ls())
source('functions_rsquare_optim.R')

##-- Simulate data
set.seed(12345)
Y <- rnorm(100)
X <- Y + rnorm(100)
plot(Y~X)

##-- Check functions
R_square_cat(cutpoints=c(-0.5,0.5),Y,X)  # R-square with 2 cutpoints: -0.5 & 0.5
ui_matrix(2)                             # contraint matrix (see ?constrOptim): 1) all cutpoints>min(X); 2) all cutpoints<max(X); 3) cutpoins are sorted
ci_vector(2,X)                           # contraint vector (see ?constrOptim): 1) all cutpoints>min(X); 2) all cutpoints<max(X); 3) cutpoins are sorted
theta_vector(2,X)


##-- Create parameters and optimize
n_cutpoints <- 3
ui=ui_matrix(n_cutpoints)
ci=ci_vector(n_cutpoints,X)
theta=theta_vector(n_cutpoints,X)

sol <- constrOptim(theta=theta,f=R_square_cat,grad=NULL,ui=ui,ci=ci,Y=Y,X=X)
sol$par     # optim cutpoints
sol$value   # = -R^2 (change the sign)

##-- Check if optimize works -----------------------------
x_cat <- cut(X,breaks = c(min(X,na.rm = TRUE),sol$par,max(X,na.rm = TRUE)), include.lowest = TRUE)
summary(lm(Y~x_cat))  # Obtain R^2

# Try nsim random values and check if all of them provide lower values of the R^2
nsim <- 1000
R2_random <- c()
for(i in 1:nsim){
  random_cutpoints <- sort(runif(n_cutpoints,min(X,na.rm = TRUE),max(X,na.rm = TRUE)))
  x_cat <- cut(X,breaks = c(min(X,na.rm = TRUE),random_cutpoints,max(X,na.rm = TRUE)), include.lowest = TRUE)
  R2_random[i] <- summary(lm(Y~x_cat))$r.squared
}
summary(R2_random) # Not perfect, but almost
