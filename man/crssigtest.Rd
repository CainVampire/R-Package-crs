\name{crssigtest}
\alias{crssigtest}

\title{Regression Spline Significance Test with Mixed Data Types}
\description{
  \code{crssigtest} implements a consistent test of significance of
  an explanatory variable in a nonparametric regression setting that is
  analogous to a simple \eqn{t}-test in a parametric regression
  setting. The test is based on Ma and Racine (2011).
}
\usage{
crssigtest(model=NULL,
           index=NULL,
           boot.num=399)
}

\arguments{
  \item{model}{
    a \code{crs} model object.
  }
  \item{index}{
    a vector of indices for the columns of \code{xz} for which the
    test of significance is to be conducted. Defaults to (1,2,\dots,\eqn{p})
    where \eqn{p} is the number of columns in \code{xdat}.
  }
  \item{boot.num}{
    an integer value specifying the number of bootstrap replications to
    use. Defaults to \code{399}.
  }
}

\value{
  \code{crssigtest} returns an object of type
  \code{sigtest}. \code{\link{summary}} supports \code{sigtest}
  objects. It has the following components:
  
  \item{index}{ the vector of indices input }
  \item{F}{ the vector of statistics \code{R} }
  \item{P}{ the vector of P-values for each statistic in \code{F}}
}
\references{
  Li, Q. and J.S. Racine (2007), \emph{Nonparametric Econometrics:
    Theory and Practice,} Princeton University Press.

  Ma, S. and J.S. Racine, (2011), \dQuote{Inference for Regression
  Splines with Categorical and Continuous Predictors,} Working Paper.

}
\author{
  Jeffrey S. Racine\email{racinej@mcmaster.ca}
}

\section{Usage Issues}{
  Caution: bootstrap methods are, by their nature, \emph{computationally
  intensive}. This can be frustrating for users possessing large
  datasets. For exploratory purposes, you may wish to override the
  default number of bootstrap replications, say, setting them to
  \code{boot.num=99}.
}

\examples{
options(crs.messages=F)
set.seed(42)

n <- 1000
z <- rbinom(n,1,.5)
x1 <- rnorm(n)
x2 <- runif(n,-2,2)
z <- factor(z)
## z is irrelevant
y <- x1 + x2 + rnorm(n)

model <- crs(y~x1+x2+z)

crssigtest(model)
}
\keyword{ nonparametric }