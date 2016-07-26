#install package rstan
install.packages("rstan")
library(rstan)
library(RcppEigen)

#These options allow you to automatically save a bare version of a compiled Stan program to the hard disk so that it does not need to be recompiled and to execute multiple Markov chains in parallel.

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

setwd("/Users/Olivialeilei/desktop")
data <-read.table(file ="data.txt", header = TRUE)
data <-subset(data, sex=="fem")

#create stan data
dat <- list(N        = nrow(data),
            p        = 3,
            ethnic   = as.factor(data$ethnic),
            age      = as.factor(data$age),
            spnbmd   = as.factor(data$spnbmd))

scode <-"
data {
int<lower=0> N;
# Number of parameters
int<lower=0> p;
# Variables
real<lower=0> age[N];
int<lower=0>  ethnic[N];
real spnbmd[N];
}
 
 parameters {
# Define parameters to estimate
real beta[p];

#standard deviation (a positive real number)
  real<lower=0> sigma;
}
 
transformed parameters  {
#Mean
 real mu[N];
 for (i in 1:N) {
  mu[i] <- beta[1] + beta[2]*age[i] + beta[3]*ethnic[i]; 
}
}

 model {
#priors
beta[1]~normal(0,sigma);
#Likelihood part of Bayesian inference
    spnbmd ~ normal(mu, sigma);  
}
"

cat(scode)
fit <- stan(model_code = scode, data = dat, chains = 3, iter = 1000)
print(fit, pars = c("beta","sigma"))



