# Tree-Based Methods
Tree-Based Methods involve stratifying or segmenting the predictor space into a number of simple regions. 

### Decision trees
Definition: Since the set of splitting rules used to segment the predictor space can be summarized in a tree, these types of approaches are known as decision tree methods.
Note: The number in each leaf is the mean of the response for the observations.

### Regression trees
<img src="Images\regtree.PNG">

Understanding: The regions R1, R2, and R3 are known as terminal nodes or leaves of the tree. The points along the tree where the predictor space
is split are referred to as internal nodes. We refer to the segments of the trees that connect the nodes as branches.

<img src="Images\regtree0.PNG">
Compared with Figure 8.2 above,  this figure is likely an over-simplification of the true relationship between Hits, Years, and Salary. However, it has advantages over other types of regression models: it is easier to interpret, and has a nice graphical representation.

### Prediction via Stratification of the Feature Space
We now discuss the process of building a regression tree. Roughly speaking, there are two steps.
+ 1. We divide the predictor space — that is, the set of possible values for X1, X2,...,Xp — into J distinct and non-overlapping regions, R1, R2,...,RJ .
+ 2. For every observation that falls into the region Rj , we make the same
prediction, which is simply the mean of the response values for the
training observations in Rj .