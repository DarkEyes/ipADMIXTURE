#'
#'
#' @export
#'
printClustersFromLabels<-function(obj,labels)
{
  N<-dim(obj$Qmat)[1]
  clsIDVec<-sort(unique(obj$indexClsVec) )

  if(missing(labels))
  {
    IDs<-1:N
    for(cls in clsIDVec)
    {
      print("===============")
      M<-sum(obj$indexClsVec == cls)
      print(sprintf("ID%d, md%.2f, N%d",cls,obj$homoClusters[[cls]]$maxDiffAdmixRatio,M))
      print(IDs[obj$indexClsVec == cls])
    }
  }else{
    print("Overall labels")
    print("===============")
    str<-""
    allLabelVec<-unique(labels)
    countVec<-c()
    for(label_itr in  allLabelVec)
    {
      c1<-sum( labels == label_itr )
      countVec<-c(countVec,c1)
      str<-sprintf("%s%s(%d)",str,label_itr,c1)
    }
    print(str)

    for(cls in clsIDVec)
    {
      print("===============")
      currLabels<-labels[obj$indexClsVec == cls]
      currLabelsMembers<-unique(currLabels)
      print(sprintf("ID%d, md%.2f, N%d",cls,obj$homoClusters[[cls]]$maxDiffAdmixRatio,length(currLabels)))

      str<-""
      for(label_itr in currLabelsMembers)
      {
        c1<-sum( currLabels == label_itr )
        c2<-countVec[allLabelVec == label_itr]
        str<-sprintf("%s%s(%d/%d)",str,label_itr,c1,c2)
      }
      print(str)

    }
  }
}
