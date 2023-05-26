# Tree-Based Methods
Tree-Based Methods involve stratifying or segmenting the predictor space into a number of simple regions. 

### Decision trees
Definition: Since the set of splitting rules used to segment the predictor space can be summarized in a tree, these types of approaches are known as decision tree methods.
Note: The number in each leaf is the mean of the response for the observations.

### Regression trees
<img src="TreeImages\regtree.PNG">

Understanding: The regions R1, R2, and R3 are known as terminal nodes or leaves of the tree. The points along the tree where the predictor space
is split are referred to as internal nodes. We refer to the segments of the trees that connect the nodes as branches.

Algorithm for building a regression tree
<img src="TreeImages\Algreg.PNG">

<img src="TreeImages\regtree0.PNG">
Compared with Figure 8.2 above,  this figure is likely an over-simplification of the true relationship between Hits, Years, and Salary. However, it has advantages over other types of regression models: it is easier to interpret, and has a nice graphical representation.

### Prediction via Stratification of the Feature Space
We now discuss the process of building a regression tree. Roughly speaking, there are two steps.
+ 1. We divide the predictor space — that is, the set of possible values for X1, X2,...,Xp — into J distinct and non-overlapping regions, R1, R2,...,RJ .
+ 2. For every observation that falls into the region Rj , we make the same
prediction, which is simply the mean of the response values for the
training observations in Rj .

Construct the regions R1,...,RJ:  In theory, the regions could have any shape. However, we choose to divide the predictor space into high-dimensional rectangles, or boxes, for simplicity and for ease of interpretation of the resulting predictive model. The goal is to find boxes R1,...,RJ that minimize the RSS, given by

<img src="TreeImages\f1.PNG">

### recursive binary splitting
The approach is top-down because it begins at the top of the tree (at which point all observations belong to a single region) and then successively splits the predictor space; each split is indicated via two new branches further down on the tree. It is greedy because at each step of the tree-building process, the best split is made at that particular step, rather than looking ahead and picking a split that will lead to a better tree in some future step.
In order to perform recursive binary splitting, we first select the predictor Xj and the cutpoint s such that splitting the predictor space into the regions {X|Xj < s} and {X|Xj ≥ s} leads to the greatest possible reduction in RSS. (The notation {X|Xj < s} means the region of predictor
space in which Xj takes on a value less than s.) That is, we consider all predictors X1,...,Xp, and all possible values of the cutpoint s for each of the predictors, and then choose the predictor and cutpoint such that the resulting tree has the lowest RSS. In greater detail, for any j and s, we define the pair of half-planes

<img src="TreeImages\f2.PNG">
and we seek the value of j and s that minimize the equation

<img src="TreeImages\f3.PNG">
Finding the values of j and s that minimize (8.3) can be done quite quickly, especially when the number of features p is not too large.
Next, we repeat the process, looking for the best predictor and best cutpoint in order to split the data further so as to minimize the RSS within each of the resulting regions. However, this time, instead of splitting the entire predictor space, we split one of the two previously identified regions. We now have three regions. Again, we look to split one of these three regions further, so as to minimize the RSS. The process continues until a stopping criterion is reached; for instance, we may continue until no region contains more than five observations.

### Tree Pruning
Reason for this method: A smaller tree with fewer splits (that is, fewer regions R1,...,RJ ) might lead to lower variance and better interpretation at the cost of a little bias. 
Definition: First to grow a very large tree T0, and then prune it back in order to obtain a subtree. 
Cost complexity pruning (weakest link pruning): Rather than considering every possible subtree, we consider a sequence of trees indexed by a nonnegative tuning parameter α. For each value of α there corresponds a subtree T ⊂ T0 such that
<img src="TreeImages\f4.PNG">

is as small as possible. Here |T| indicates the number of terminal nodes of the tree T, Rm is the rectangle (i.e. the subset of predictor space)corresponding to the mth terminal node, and ˆyRm is the predicted response associated with Rm—that is, the mean of the training observations in Rm.The tuning parameter α controls a trade-off between the subtree’s complexity and its fit to the training data. When α = 0, then the subtree will simply equal T0, because then (8.4) just measures the training error. However, as α increases, there is a price to pay for having a tree with many terminal nodes, and so the quantity (8.4) will tend to be minimized for a smaller subtree. Equation 8.4 is reminiscent of the lasso (6.7) from Chapter 6, in which a similar formulation was used in order to control the complexity of a linear model.
It turns out that as we increase α from zero in (8.4), branches get pruned from the tree in a nested and predictable fashion, so obtaining the whole sequence of subtrees as a function of α is easy. We can select a value of α using a validation set or using cross-validation. We then return to the full data set and obtain the subtree corresponding to α. This process is summarized in Algorithm 8.1

#### unpruned tree and comparison for testing
<img src="TreeImages\unpruned.PNG">

<img src="TreeImages\comparison.PNG">
Figures 8.4 and 8.5 display the results of fitting and pruning a regression tree on the Hitters data, using nine of the features. First, we randomly divided the data set in half, yielding 132 observations in the training set and 131 observations in the test set. We then built a large regression tree on the training data and varied α in (8.4) in order to create subtrees with different numbers of terminal nodes. Finally, we performed six-fold cross-validation in order to estimate the cross-validated MSE of the trees as a function of α. (We chose to perform six-fold cross-validation because 132 is an exact multiple of six.) The unpruned regression tree is shown in Figure 8.4. The green curve in Figure 8.5 shows the CV error as a function of the number of leaves, while the orange curve indicates the test error. Also shown are standard error bars around the estimated errors. For reference, the training error curve is shown in black. The CV error is a reasonable approximation of the test error: the CV error takes on its minimum for a three-node tree, while the test error also dips down at the three-node tree (though it takes on its lowest value at the ten-node tree). The pruned tree containing three terminal nodes is shown in Figure 8.1.

### Classification Trees
For a classification tree, we predict that each observation belongs to the most commonly occurring class of training observations in the region to which it belongs.
