#'
#'@export
#'
biclustFunc<-function(Qmat,admixRatioThs=0.5,iter.max=100000)
{
  ancestorD<-dim(Qmat)[2]
  maxDiffAdmixRatio<-0
  meanDiffAdmixRatio<-rep(0,ancestorD)
  minN<-1
  clusterInx<-c()
  heteroFlag<-FALSE

  if(dim(Qmat)[1]>ancestorD)
  {

    clusters <- hclust(dist(Qmat), method = "average")
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
