#' @title  Iterative Pruning Population Admixture Inference Framework (ipADMIXTURE)
#' @author Chainarong Amornbunchornvej, \email{chai@@ieee.org}
#'
#' @description
#' A data clustering package based on admixture ratios (Q matrix) of population structure.
#'
#' The framework is based on iterative Pruning procedure that performs data clustering by splitting a given population into subclusters until meeting the condition of stopping criteria the same as ipPCA, iNJclust, and IPCAPS frameworks.
#' The package also provides a function to retrieve phylogeny tree that construct a neighbor-joining tree based on a similar matrix between clusters. By given multiple Q matrices with varying a number of ancestors (K),
#' the framework define a similar value between clusters i,j as a minimum number K that makes majority of members of two clusters are in the different clusters.
#' This K reflexes a minimum number of ancestors we need to splitting cluster i,j into different clusters if we assign K clusters based on maximum admixture ratio of individuals.
#'
#'
#'@param Qmat is a Q matrix that contains admixture ratios of all individuals where the \code{Qmat[i,j]} represents the admixture ratio of ancestor j for individual i.
#'@param admixRatioThs is a threshold to determine that if a cluster has \code{maxDiffAdmixRatio} lower than threshold, then the cluster is a homogeneous cluster.
#'@param method is a method parameter of \code{hclust} object for hierarchical clustering analysis. The default is "average".
#'
#' @return This function returns clustering results in a form of an object of ipADMIXTURE class.
#' The object contains the following items.
#'
#' \item{indexClsVec}{is a vector of clustering assignment where \code{indexClsVec[i]} is a cluster number of individual i.}
#' \item{homoClusters}{is a list of cluster objects where each object contains member indices, cluster's \code{maxDiffAdmixRatio}, ID, etc. }
#' \item{maxDiffAdmixRatioVec}{is a vector of \code{maxDiffAdmixRatio}s for all clusters.}
#' \item{Qmat}{is a Q matrix that contains admixture ratios of all individuals where the \code{Qmat[i,j]} represents the admixture ratio of ancestor j for individual i.}
#' \item{admixRatioThs}{is a threshold to determine that if a cluster has \code{maxDiffAdmixRatio} lower than threshold, then the cluster is a homogeneous cluster.}
#'
#'@examples
#'# Running ipADMIXTURE on Q matrix of 27 human population dataset where K = 12
#' h27pop_obj<-ipADMIXTURE(Qmat=ipADMIXTURE::human27pop_Qmat[[11]], admixRatioThs =0.15)
#'
#' @export
#'
ipADMIXTURE<-function(Qmat,admixRatioThs,method = "average")
{
  queueList<-list()
  N<-dim(Qmat)[1]
  dimensionD<-dim(Qmat)[2]


  currClusterLabel<-1
  initInxVec<-1:N
  indexClsVec<-rep(0, N)
  maxDiffAdmixRatioVec<-c()
  homoClusters<-list()

  i<-1
  Qdata<-list()
  Qdata$Qmat<-Qmat
  Qdata$indexVec<-initInxVec
  Qdata$level<-0
  Qdata$ID<-i
  Qdata$parent<- c()

  queueList[[i]]<-Qdata


  if(missing(admixRatioThs))
  {
    admixRatioThs <-2*(1/dimensionD)
  }


  itr=1
  while(length(queueList)>0)
  {
    itr=itr+1
    currL<-length(queueList)
    currQdata<-queueList[[currL]]
    queueList[[currL]]<-NULL # pop stack

    out<-ipADMIXTURE::biclustFunc(Qmat=currQdata$Qmat,admixRatioThs=admixRatioThs,method = method)

    currQdata$maxDiffAdmixRatio<-out$maxDiffAdmixRatio
    currQdata$chidrenCLS<-c()
    currQdata$leafFlag<-FALSE


    if(out$heteroFlag == TRUE)
    {
      lengthQ<-length(queueList)

      Qdata1<-list()
      Qdata1$Qmat<-out$Qmat1
      Qdata1$parent<- c(currQdata$parent,currQdata$ID)
      Qdata1$ID <- currQdata$ID*10+1
      Qdata1$indexVec<- currQdata$indexVec[out$clusterInx ==1]
      Qdata1$level<-currQdata$level +1

      Qdata2<-list()
      Qdata2$Qmat<-out$Qmat2
      Qdata2$parent<- c(currQdata$parent,currQdata$ID)
      Qdata2$ID <- currQdata$ID*10+2
      Qdata2$indexVec<- currQdata$indexVec[out$clusterInx ==2]
      Qdata2$level<-currQdata$level +1

      queueList[[lengthQ+1]] <- Qdata1 # push stack
      queueList[[lengthQ+2]] <- Qdata2 # push stack

    }
    else
    {
      currQdata$clsName<-currClusterLabel
      currQdata$leafFlag<-TRUE
      indexClsVec[currQdata$indexVec] <- currClusterLabel

      homoClusters[[currClusterLabel]]<-currQdata

      maxDiffAdmixRatioVec<-c(maxDiffAdmixRatioVec,out$maxDiffAdmixRatio )

      currClusterLabel<-currClusterLabel+1
    }
  }

  value<-list(indexClsVec=indexClsVec,homoClusters=homoClusters,maxDiffAdmixRatioVec=maxDiffAdmixRatioVec,Qmat=Qmat,admixRatioThs=admixRatioThs)
  attr(value, 'class') <- 'ipADMIXTURE'
  value
}
