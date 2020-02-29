#'
#'
#' @export
#' @importFrom RColorBrewer brewer.pal
#'
plotAdmixClusters<-function(obj)
{
  N<-dim(obj$Qmat)[1]
  a1<-order(obj$indexClsVec)
  coul <- brewer.pal(12, "Paired")
  barplot(t(obj$Qmat[a1,]), border = NA, space = 0,xlab = "Individuals", ylab = "Admixture coefficients",col = coul)
  axis(side = 1,at = 1:N, labels = obj$indexClsVec[ a1] )
}
