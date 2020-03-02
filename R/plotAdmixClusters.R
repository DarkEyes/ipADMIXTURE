#' plotAdmixClusters
#'
#' plotAdmixClusters is function that plots admixture ratios
#' where the x axis represents individuals with cluster labels and y axis represents admixture ratios.
#'@param obj is an object of ipADMIXTURE class.
#'
#'@examples
#' h27pop_obj<-ipADMIXTURE(Qmat=ipADMIXTURE::human27pop_Qmat[[11]], admixRatioThs =0.15)
#' ipADMIXTURE::plotAdmixClusters(h27pop_obj)
#'
#' @export
#' @importFrom RColorBrewer brewer.pal
#' @importFrom graphics axis barplot
#'
plotAdmixClusters<-function(obj)
{
  N<-dim(obj$Qmat)[1]
  a1<-order(obj$indexClsVec)
  coul <- brewer.pal(12, "Paired")
  barplot(t(obj$Qmat[a1,]), border = NA, space = 0,xlab = "Individuals (with clusters labels)", ylab = "Admixture ratios",col = coul)
  axis(side = 1,at = 1:N, labels = obj$indexClsVec[ a1] )
}
