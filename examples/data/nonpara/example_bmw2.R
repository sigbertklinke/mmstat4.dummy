library("np")
library("plot.3d")
data(Boston, package="MASS")
model <- npreg(medv~lstat+rm, data=Boston)
par(mfrow=c(1,1))
new3d("s") %>% regression3d(model, Boston) %>% plot3d()
plot(model, view="fixed", theta=45)