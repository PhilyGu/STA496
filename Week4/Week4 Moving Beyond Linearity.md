## Moving Beyond Linearity

**Polynomial Regression**

Polynomial regression extends the linear model by adding extra predictors, obtained 
by raising each of the original predictors to a power.This approach provides a simple 
way to provide a non-linear fit to data.

**Step Functions**

Step functions cut the range of a variable into K distinct regions in
order to produce a qualitative variable. This has the effect of fitting
a piecewise constant function.

<img src="Images\stepdef.PNG">

where I(·) is an indicator function that returns a 1 if the condition is true, 
and returns a 0 otherwise.

<img src="Images\somedef.PNG">
(Notice: This is similar to the fact that we need only two dummy variables to code a 
qualitative variable with three levels, provided that the model will contain an intercept.)

Limitation for this method: unless there are natural breakpoints in the predictors,
piecewise-constant functions can miss the action.

**Basis Functions**

Polynomial and piecewise-constant regression models are in fact special
cases of a basis function approach.

<img src="Images\basisdef.PNG">

Importantly, this means that all of the inference tools for linear
models that are discussed in Chapter 3, such as standard errors for the
coefficient estimates and F-statistics for the model’s overall significance,
are available in this setting.

### Regression Splines

Regression splines are more flexible than polynomials and step functions, and in fact are an 
extension of the two. They involve dividing the range of X into K distinct regions. Within each 
region, a polynomial function is fit to the data. However, these polynomials are constrained so 
that they join smoothly at the region boundaries, or knots. Provided that the interval is divided 
into enough regions, this can produce an extremely flexible fit.

**Piecewise Polynomials**
Instead of fitting a high-degree polynomial over the entire range of X, piecewise polynomial regression 
involves fitting separate low-degree polynomial over different regions of X. For example, a piecewise 
cubic polynomial works by fitting a cubic regression model of the form

<img src="Images\piecedef.PNG">
where the coefficients β0, β1, β2, and β3 differ in different parts of the range
of X. 

<img src="Images\piecedef.PNG">
Knots: The points where the coefficients change are called knots.

**The Spline Basis Representation**
A cubic spline with K knots can be modeled as

<img src="Images\cubic.PNG">

### truncated power basis:
<img src="Images\truncateddef.PNG">
where ξ is the knot.
In other words, in order to fit a cubic spline to a data set with K knots, we
perform least squares regression with an intercept and 3 + K predictors, of
the form X, X2, X3, h(X, ξ1), h(X, ξ2),...,h(X, ξK), where ξ1,..., ξK are
the knots. This amounts to estimating a total of K + 4 regression coefficients; for this reason, fitting a cubic spline with K knots uses K+4 degrees of freedom.