#'
#'@importFrom ape nj
#'@export
#'
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
