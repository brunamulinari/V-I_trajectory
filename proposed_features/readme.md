# proposed_features
In this folder are the codes of the new features proposed in the article.

# Files: 
* fe_vi_STS: main function. Extract 12 features of V-I trajectory in steady and transient states.
* averagesl: this function determine the average slope variation.
* difbdistangbp: calculate difference between distances, maximum point to minimum, in the state stationary and transient.
* distangbp: calculates the distance between the maximum and minimum points of the V-I trajectory. It also, calculates the angle formed.
* maximumdistance: calculates the maximum distance between all points in V-I trajectory and the origin (0,0).
* overshoot: calculates the current overshoot using the difference between the maximum points of the trajectories V-I in the transient 
period Wt and in the steady period Wp.
* variationsofssl: Detects how many variations of the signal slope exist given a criterion for excluding small variations.
* vicentroid: calculates the distance of the centroid of the V-I trajectory in relation to the origin and the angle formed between these 
points. In adittion, a distance metric is caculate between the centroids of trajectories in the steady and transient states.
* vilentgh: calculates the lentgh of V-I trajectory in steady state.
