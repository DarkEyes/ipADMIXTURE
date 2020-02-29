#'
#'@importFrom treemap treemap
#'@export
#'
plotClusterLeaves<-function(obj)
{
  nodeN<-length(obj$homoClusters)
  levels<-c()
  strCLS<-c()
  popSize<-c()
  maxDiffAdmixRatioVec<-c()


  for(i in seq(1,nodeN))
  {
    currNode<-obj$homoClusters[[i]]
    md<-obj$homoClusters[[i]]$maxDiffAdmixRatio
    maxDiffAdmixRatioVec<-c(maxDiffAdmixRatioVec,md)
    popSize<-c(popSize,dim(obj$homoClusters[[i]]$Qmat)[1])

    str1<-""

    str1<-sprintf("%sID%d",str1,obj$homoClusters[[i]]$clsName)

    str1<-sprintf("%s N%d, md:%.2f ",str1,dim(obj$homoClusters[[i]]$Qmat)[1],md)

    strCLS<-c(strCLS,str1)
  }
    treedat<-data.frame(strCLS,"maxDifferenceAdmixtureRatio"=maxDiffAdmixRatioVec,popSize)
    treemap::treemap(treedat,
            index=c("strCLS"),
            vSize="popSize",
            vColor="maxDifferenceAdmixtureRatio",title.legend ="|Maximal-admixture-ratio differences| (md)",
            type="value",overlap.labels = 1, title = "Homogeneous clusters" )
}
labelCount<-function(labels)
{
  str<-""
  allLabelVec<-unique(labels)
  countVec<-c()
  for(label_itr in  allLabelVec)
  {
    c1<-sum( labels == label_itr )
    countVec<-c(countVec,c1)
    str<-sprintf("%s%s(%d)",str,label_itr,c1)
  }
  return(str)
}
