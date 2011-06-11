## This demo considers a setting with one endogenous regressor, one
## exogenous regressor, and one instrument.

## This illustration was made possible by Samuele Centorrino
## <samuele.centorrino@univ-tlse1.fr>

require(crs)

## Turn off screen I/O for crs()

opts <- list("DISPLAY_DEGREE"=0)

set.seed(42)

n <- as.numeric(readline(prompt="Input the number of observations desired: "))
method <- as.numeric(readline(prompt="Input the method (0=Landweber-Fridman, 1=Tikhonov): "))
method <- ifelse(method==0,"Landweber-Fridman","Tikhonov")
nmulti <- as.numeric(readline(prompt="Input the number of multistarts desired (e.g. 10): "))
num.eval <- as.numeric(readline(prompt="Input the number of evaluation observations desired (e.g. 50): "))

v  <- rnorm(n,mean=0,sd=.27)
eps <- rnorm(n,mean=0,sd=0.05)
u <- -0.5*v + eps
w <- rnorm(n,mean=0,sd=1)
z <- 0.2*w + v
x <- rnorm(n)

## In Darolles et al (2011) there exist two DGPs. The first is
## phi(z)=z^2. Here we add an exogenous regressor.

phi <- function(z) { z^2 }
eyz <- function(z) { z^2 -0.325*z }

y <- phi(z) + 0.1*x^3 + u

## In evaluation data sort z for plotting and hold x constant at its
## median

model.iv <- crsiv(y=y,z=z,w=w,x=x,nmulti=nmulti,method="Landweber-Fridman",deriv=1)

summary(model.iv)

# Perspective plot
z.seq <- seq(min(z),max(z),length=num.eval)
x.seq <- seq(min(x),max(x),length=num.eval)
x.grid <- expand.grid(z.seq,x.seq)
newdata <- data.frame(z=x.grid[,1],x=x.grid[,2])
z <- matrix(predict(model.iv,newdata=newdata),num.eval,num.eval)
persp(x=z.seq,y=x.seq,z=z,
      xlab="z",ylab="x",zlab="y",
      ticktype="detailed",
      col=FALSE,
      border="red",
      main="phi(z,x)",
      theta=45,phi=45)

## Perspective plot - derivative wrt z
z <- matrix(attr(predict(model.iv,newdata=newdata),"deriv.mat")[,1],num.eval,num.eval)
persp(x=z.seq,y=x.seq,z=z,
      xlab="z",ylab="x",zlab="y",
      ticktype="detailed",      
      border="red",
      col=FALSE,
      main="d g(z,x)/d z (x=med(x))",
      theta=45,phi=45)

## Perspective plot - derivative wrt x
z <- matrix(attr(predict(model.iv,newdata=newdata),"deriv.mat")[,2],num.eval,num.eval)
persp(x=z.seq,y=x.seq,z=z,
      xlab="z",ylab="x",zlab="y",
      ticktype="detailed",      
      border="red",
      col=FALSE,
      main="d g(z,x)/d x (z=med(z))",
      theta=45,phi=45)