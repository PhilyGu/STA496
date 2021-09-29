## Moving Beyond Linearity

**Polynomial Regression**

Polynomial regression extends the linear model by adding extra predictors, obtained by raising each of the original predictors to a power.
This approach provides a simple way to provide a non-linear fit to data.

**Step Functions**
Step functions cut the range of a variable into K distinct regions in
order to produce a qualitative variable. This has the effect of fitting
a piecewise constant function.

<img src="Images\stepdef.PNG">

where I(·) is an indicator function that returns a 1 if the condition is true, and returns a 0 otherwise.

<img src="Images\somedef.PNG">
(Notice: This is similar to the fact that we need only two dummy variables to code a qualitative
variable with three levels, provided that the model will contain an intercept.)

Limitation for this method: unless there are natural breakpoints in the predictors,
piecewise-constant functions can miss the action.

**Basis Functions**
Polynomial and piecewise-constant regression models are in fact special
cases of a basis function approach.
