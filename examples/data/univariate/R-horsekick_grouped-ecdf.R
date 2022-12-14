pdf(file = "R-horsekick_grouped-ecdf.pdf", width = 4, height = 4, pointsize = 8)
#Empirical cumulative distribution function (ecdf) example. Data = von Bortkiewicz's famous dataset of deaths by horse kick in Prussian cavalry corps
library("pscl")
par(mar=c(4,4,5,3)+0.1)
X <- tapply(prussian$y, prussian$year, sum)
h <- hist(X, plot=F)
xval <- c( -1, h$breaks, 21)
ecdf <- c(0, 0, cumsum(h$counts)/sum(h$counts), 1)
plot(xval[2:10], ecdf[2:10], pch=19, xlab="Deaths per year", ylab=expression(F[n](x)), xlim=c(0,20))
title("Deaths by horsekick in\nPrussian cavalry corps, 1875-94", line=2)
abline(h=0, col="grey")
abline(h=1, col="grey")
lines(xval, ecdf)
dev.off()
if (interactive()) browseURL(paste0(getwd(),"/R-horsekick_grouped-ecdf.pdf"))


