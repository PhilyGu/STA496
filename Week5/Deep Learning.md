# Deep Learning
The cornerstone of deep learning is the neural network.

### Single Layer Neural Networks
Distinction: what distinguishes neural networks from these methods is the particular structure of the model. 

<img src="DLImages\basisdef.PNG">

 Figure 10.1 shows a simple feed-forward neural network for modeling a quantitative response using p = 4 predictors. In the terminology of neural networks, the four features X1,...,X4 make up the units in the input layer.The arrows indicate that each of the inputs from the input layer feeds into each of the K hidden units (we get to pick K; here we chose 5). The neural network model has the form
 <img src="DLImages\fom1.PNG">

 It is built up here in two steps. First the K activations Ak, k = 1, . . . , K, in the hidden layer are computed as functions of the input features X1,...,Xp,
 <img src="DLImages\fom2.PNG">

 where g(z) is a nonlinear activation function that is specified in advance. We can think of each Ak function as a different transformation hk(X) of the original features, much like the basis functions of Chapter 7. These K activations from the hidden layer then feed into the output layer, resulting in
 <img src="DLImages\fom3.PNG">

 a linear regression model in the K = 5 activations. All the parameters
β0,..., βK and w10,...,wKp need to be estimated from data. In the early instances of neural networks, the sigmoid activation function was favored,
<img src="DLImages\sigmoid.PNG">

which is the same function used in logistic regression to convert a linear function into probabilities between zero and one. The preferred choice in modern neural networks is the ReLU (rectified linear ReLU unit) activation function, which takes the form
<img src="DLImages\relu.PNG">

A ReLU activation can be computed and stored more efficiently than a sigmoid activation. Although it thresholds at zero, because we apply it to a
linear function the constant term w_{k0} will shift this inflection point.

#### Importance of nonlinearity
The nonlinearity in the activation function g(·) is essential, since without it the model f(X) in (10.1) would collapse into a simple linear model in X1,...,Xp. Moreover, having a nonlinear activation function allows the model to capture complex nonlinearities and interaction effects. Consider
a very simple example with p = 2 input variables X = (X1, X2), and K = 2 hidden units h1(X) and h2(X) with g(z) = z2. We specify the other parameters as
<img src="DLImages\matrix.PNG">

This means that 
<img src="DLImages\equation.PNG">

Then plugging (10.7) into (10.1), we get
<img src="DLImages\equation2.PNG">

So the sum of two nonlinear transformations of linear functions can give us an interaction! In practice we would not use a quadratic function for 
g(z), since we would always get a second-degree polynomial in the original coordinates X1,...,Xp. The sigmoid or ReLU activations do not have such
a limitation.
Fitting a neural network requires estimating the unknown parameters in(10.1). For a quantitative response, typically squared-error loss is used, so
that the parameters are chosen to minimize
<img src="DLImages\loss.PNG">

### Multilayer Neural Networks
<img src="DLImages\neu2.PNG">

Figure 10.4 shows a multilayer network architecture that works well for solving the digit-classification task. It differs from Figure 10.1 in several ways:
+ It has two hidden layers L1 (256 units) and L2 (128 units) rather than one. Later we will see a network with seven hidden layers.
+ It has ten output variables, rather than one. In this case the ten variables really represent a single qualitative variable and so are quite dependent. (We have indexed them by the digit class 0–9 rather than 1–10, for clarity.) More generally, in multi-task learning one can predict different responses simultaneously with a single network; they all have a say in the formation of the hidden layers.
+ The loss function used for training the network is tailored for the multiclass classification task.

The first hidden layer is as in (10.2), with
<img src="DLImages\fom4.PNG">

for k = 1,...,K1. The second hidden layer treats the activations A(1)k of the first hidden layer as inputs and computes new activations
<img src="DLImages\fom5.PNG">

for ℓ = 1,...,K2. Notice that each of the activations in the second layer A(2)ℓ = h(2)ℓ(X) is a function of the input vector X. This is the case because while they are explicitly a function of the activations A(1)k from layer L1, these in turn are functions of X. This would also be the case with more hidden layers. Thus, through a chain of transformations, the network is able to build up fairly complex transformations of X that ultimately feed into the output layer as features.
We have introduced additional superscript notation such as h(2)ℓ(X) and w(2)ℓj in (10.10) and (10.11) to indicate to which layer the activations and weights (coefficients) belong, in this case layer 2. The notation W1 in Fig- weights ure 10.4 represents the entire matrix of weights that feed from the input layer to the first hidden layer L1. 
We now get to the output layer, where we now have ten responses rather than one. The first step is to compute ten different linear models similar
to our single model (10.1),
<img src="DLImages\fom6.PNG">

for m = 0, 1,..., 9.
If these were all separate quantitative responses, we would simply set each fm(X) = Zm and be done. However, we would like our estimates to represent class probabilities fm(X) = Pr(Y = m|X), just like in multinomial logistic regression in Section 4.3.5. So we use the special softmax activation function
<img src="DLImages\fom7.PNG">

for m = 0, 1,..., 9. This ensures that the 10 numbers behave like probabilities (non-negative and sum to one). Even though the goal is to build
a classifier, our model actually estimates a probability for each of the 10 classes. The classifier then assigns the image to the class with the highest probability.
To train this network, since the response is qualitative, we look for coefficient estimates that minimize the negative multinomial log-likelihood
<img src="DLImages\fom7.PNG">

also known as the cross-entropy. This is a generalization of the criterion (4.5) for two-class logistic regression. Details on how to minimize this entropy objective are given in Section 10.7. If the response were quantitative, we would instead minimize squared-error loss as in (10.9).