#' A list of Q matrices of 27 human populations
#'
#' A dataset containing admixture ratios of 544 individuals from 27 human populations where the number of ancestors ranges from 2 to 12.
#' This dataset was the result of running ADMIXTURE software developed by Zhou, H., et al. (2011). A quasi-Newton acceleration for high-dimensional optimization algorithms. Statistics and computing, 21(2), 261-273.
#' on the 27-human-population dataset published by Xing, J., Watkins, W. S. et al. (2009). Fine-scaled human genetic structure revealed by SNP microarrays. Genome research, 19(5), 815-825.
#'
#' @format A list of Q matrices of 544 individuals from 27 human populations. There are 2-12 ancestors in the list.
#'   \describe{
#'   \item{human27pop_Qmat}{ It is list of Q matrices that contains admixture ratios of 544 individuals from the 27 population human dataset.
#'    \code{human27pop_Qmat[[k]][i,j]} is the admixture ratio of jth ancestor for ith individual in the (k+1)-ancestor Q matrix.}
#'   ...
#' }
"human27pop_Qmat"

#' Labels of 27 human populations
#'
#' @format Labels of 27 human populations. :
#' \describe{
#'    \item{human27pop_labels}{It is a vector of labels of 544 individuals. There are 27 populations.}
#'   ...
#' }
"human27pop_labels"

#' A list of Q matrices of simulation of 20 populations
#'
#' A dataset containing admixture ratios of 1200 individuals from 20 simulation populations where the number of ancestors ranges from 2 to 18.
#' This dataset was the result of running LEA library developed by Frichot, E., & François, O. (2015). LEA: An R package for landscape and ecological association studies. Methods in Ecology and Evolution, 6(8), 925-929.
#' on the 20-simulation-population dataset published by Limpiti, T., et al. (2014). iNJclust: iterative neighbor-joining tree clustering framework for inferring population structure. IEEE/ACM transactions on computational biology and bioinformatics, 11(5), 903-914.
#'
#' @format A list of Q matrices of 1200 individuals from 20 populations. There are Q matrices that have the number of ancestors ranges from from 2 to 18.
#'   \describe{
#'   \item{UD1_Qmat}{ It is list of Q matrices that contains admixture ratios of 1200 individuals from the 20-population dataset.
#'    \code{UD1_Qmat[[k]][i,j]} is the admixture ratio of jth ancestor for ith individual in the (k+1)-ancestor Q matrix.}
#'   ...
#' }
"UD1_Qmat"

#' Labels of 20 simulation populations
#'
#' @format Labels of 20 populations. :
#' \describe{
#'    \item{UD1labels}{It is a vector of labels of 1200 individuals. There are 20 populations.}
#'   ...
#' }
"UD1labels"
