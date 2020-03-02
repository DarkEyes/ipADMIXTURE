#' getPhyloTree
#'
#' getPhyloTree is function that reports a phylogenetic tree of clusters based on admixture analysis.
#' The phylogeny tree that construct a neighbor-joining tree based on a similar matrix between clusters.
#' By given multiple Q matrices with varrying a number of ancestors (K), the framework define a similar value between clusters i,j as a minimum number \code{K} that makes majority of members of two clusters are in the different clusters.
#' This \code{K} reflexes a minimum number of ancestors we need to splitting cluster i,j into different clusters if we assign \code{K} clusters based on maximum admixture ratio of individuals.
#'@param QmatList is list of Q matrix where \code{QmatList[[k]]} is a Q matrix with \code{k+1} ancestors.
#'@param indexClsVec is a vector of clustering assignement where \code{indexClsVec[i]} is a cluster number of individual i.
#'
#'@return This function returns an object of nj tree as well as a matrix \code{minDiffAncestorClsMat} that is used as a similarity matrix.
#'
#' \item{tree}{is an object of nj tree calcuated by ape::nj() function on a dissimilarity version of \code{minDiffAncestorClsMat}. }
#' \item{minDiffAncestorClsMat}{is a minimum-ancestor-number matrix where \code{minDiffAncestorClsMat[i,j]} is a minimum number of ancestors that make i and j to be different clusters while \code{minDiffAncestorClsMat[i,j]-1} makes majority of members from i and j belong to the same cluster.}
#'
#'@examples
#'# Running ipADMIXTURE on Q matrices (K=2-12) of 27 human population dataset.
#' h27pop_obj<-ipADMIXTURE(Qmat=ipADMIXTURE::human27pop_Qmat[[11]], admixRatioThs =0.15)
#' out<-ipADMIXTURE::getPhyloTree(ipADMIXTURE::human27pop_Qmat,h27pop_obj$indexClsVec)
#' plot(out$tree)
#'
#'@importFrom ape nj
#'@export
#'
getPhyloTree<-function(QmatList,indexClsVec)
{
  memberCLS<-sort(unique(indexClsVec))
  C<-length(memberCLS)

  N<-dim(QmatList[[2]])[1]
  K<-length(QmatList)
  minDiffAncestorMat<-matrix(C,N,N)
  for(k in seq(2,K))
  {
    clusters <- apply( QmatList[[k]], 1, which.max)
    for( i in seq(N-1))
      for (j in seq(i+1,N))
      {
        if(clusters[i]!=clusters[j] && k<minDiffAncestorMat[i,j])
        {
          minDiffAncestorMat[i,j]<-k
          minDiffAncestorMat[j,i]<-k
        }
      }
  }

  minDiffAncestorClsMat<-matrix(2,C,C)
  for( cl1 in seq(1,C-1 ) )
  {
    for( cl2 in seq(cl1+1, C) )
    {
      currMat <- minDiffAncestorMat[indexClsVec==cl1,indexClsVec==cl2]
      minDiffAncestorClsMat[cl1,cl2] <- median(currMat, na.rm = TRUE)
      minDiffAncestorClsMat[cl2,cl1] <- median(currMat, na.rm = TRUE)
    }
  }
  distMat<-C-minDiffAncestorClsMat+1
  tree<-nj(distMat)
  return(list(minDiffAncestorClsMat=minDiffAncestorClsMat,tree=tree))
}
