data(Boston, package="MASS")
# check variances
tapply(Boston$medv, Boston$rad, var)
by(Boston$medv, Boston$rad, var)
# check skewnesss
library("e1071")
tapply(Boston$medv, Boston$rad, skewness)
by(Boston$medv, Boston$rad, skewness)
# Kruskal-Wallis H test :(
kruskal.test(medv~rad, data=Boston)