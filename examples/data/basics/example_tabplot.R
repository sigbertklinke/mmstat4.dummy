library("tabplot")
library("MASS")
Boston$chas <- factor(Boston$chas)
Boston$rad <- ordered(Boston$rad)
tableplot(Boston)
