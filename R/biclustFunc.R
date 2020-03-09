#' biclustFunc function
#'
#' biclustFunc is a binary clustering function using hierarchical clustering.
#'@param Qmat is a Q matrix that contains admixture ratios of all individuals where the \code{Qmat[i,j]} represents the admixture ratio of ancestor j for individual i.
#'@param admixRatioThs is a threshold to determine that if a cluster has \code{maxDiffAdmixRatio} lower than threshold, then the cluster is a homogeneous cluster.
#'@param method is a method parameter of \code{hclust} object for hierarchical clustering analysis. The default is "average".
#'
#' @return This function returns binary clustering results.
#'
#' \item{heteroFlag}{ is a flag that represents a stutus whether a given cluster is heterogeneous (having su-clusters). It is TRUE if \code{maxDiffAdmixRatio >= admixRatioThs}.}
#' \item{clusterInx}{is a vector of clustering assignement where \code{indexClsVec[i]} is a cluster number of individual i.}
#' \item{meanDiffAdmixRatio}{is a vector of magnitude-difference of admixture ratios.
#' It is calculated by splitting a given cluster into two sub-clusters. Then, we take the absolute on the difference between mean admixture ratios of sub-clusters. }
#' \item{Qmat1}{is a Q matrix of sub-cluster #1 after splitting a given cluster into two sub-clusters that contains admixture ratios of all individuals where the \code{Qmat[i,j]} represents the admixture ratio of ancestor j for individual i.}
#' \item{Qmat2}{is a Q matrix of sub-cluster #2 after splitting a given cluster into two sub-clusters that contains admixture ratios of all individuals where the \code{Qmat[i,j]} represents the admixture ratio of ancestor j for individual i.}
#' \item{maxDiffAdmixRatio}{is a maximum of manitude-difference of admixture ratios for a given cluster before splitting into two sub-clusters. }
#'
#'@examples
#'# Running biclustFunc on Q matrix of 27 human population dataset where K = 12
#' obj<-biclustFunc(Qmat=ipADMIXTURE::human27pop_Qmat[[11]], admixRatioThs =0.15)
#'
#'@importFrom stats hclust cutree dist median
#'@export
#'
biclustFunc<-function(Qmat,admixRatioThs=0.5, method = "average")
{
  ancestorD<-dim(Qmat)[2]
  maxDiffAdmixRatio<-0
  meanDiffAdmixRatio<-rep(0,ancestorD)
  minN<-1
  clusterInx<-c()
  heteroFlag<-FALSE

  if(dim(Qmat)[1]>ancestorD)
  {

    clusters <- hclust(dist(Qmat), method = method)
    clusterInx<- cutree(clusters, 2)


    minN<-min(sum(clusterInx==1),sum(clusterInx==2))
    if(is.na(minN))
      minN <-1
  }


  if(minN<2)
  {
    Qmat1<-NULL
    Qmat2<-NULL
  }
  else
  {
    Qmat1<-Qmat[clusterInx==1,]
    Qmat2<-Qmat[clusterInx==2,]

    meanDiffAdmixRatio<-abs(colMeans(Qmat1) -colMeans(Qmat2) )
    maxDiffAdmixRatio<-max(meanDiffAdmixRatio)
    heteroFlag<-maxDiffAdmixRatio>=admixRatioThs
    if(is.na(heteroFlag) )
      heteroFlag<-FALSE
  }
  return(list(heteroFlag=heteroFlag,clusterInx=clusterInx,meanDiffAdmixRatio=meanDiffAdmixRatio,Qmat1=Qmat1,Qmat2=Qmat2,maxDiffAdmixRatio=maxDiffAdmixRatio))
}
