##-- Functions ----------------------

# Function to be optimized. It calculates the R-square given a set of 1 or more cutpoints and the continous variables X,Y
R_square_cat <- function(cutpoints,Y,X){
  x_cat <- cut(X,breaks = c(min(X,na.rm = TRUE),cutpoints,max(X,na.rm = TRUE)), include.lowest = TRUE)
  mod <- lm(Y~x_cat)
  smod <- summary(mod)
  -smod$r.squared
}

# Function to setup the constraint matrix
ui_matrix <- function(n_cutpoints){
  m1 <- diag(x=1,nrow=n_cutpoints)
  m2 <- diag(x=-1,nrow=n_cutpoints)
  if(n_cutpoints>1){
    m3 <- diag(x=-1,nrow=n_cutpoints) 
    for(i in 2:n_cutpoints) m3[i-1,i] <- 1
    m3 <- m3[-n_cutpoints,]
  }else{
    m3 <- NULL
  }
  rbind(m1,m2,m3)
}

# Function to setup the constraint array
ci_vector <- function(n_cutpoints,X){
  v <- c(rep(min(X,na.rm=TRUE) ,n_cutpoints),
         rep(-max(X,na.rm=TRUE),n_cutpoints))
  if(n_cutpoints>1) v <- c(v,rep(0,n_cutpoints-1))
  v
}

# Function to setup the initial parameters
theta_vector <- function(n_cutpoints,X){
  v <- seq(min(X,na.rm=TRUE),max(X,na.rm=TRUE),length.out = n_cutpoints + 2)[-c(1,n_cutpoints+2)]
  v
}