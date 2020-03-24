ipADMIXTURE: Iterative Pruning Population Admixture Inference Framework
==========================================================
[![Travis CI build status](https://travis-ci.com/DarkEyes/ipADMIXTURE.svg?branch=master)](https://travis-ci.com/DarkEyes/ipADMIXTURE/)
[![minimal R version](https://img.shields.io/badge/R%3E%3D-3.5.0-6666ff.svg)](https://cran.r-project.org/)
[![License](https://img.shields.io/badge/License-GPL%203-orange.svg)](https://spdx.org/licenses/GPL-3.0-only.html)

 A data clustering package based on admixture ratios (Q matrix) of population structure.
 
 The framework is based on iterative Pruning procedure that performs data clustering by splitting a given population into subclusters until meeting the condition of stopping criteria the same as ipPCA, iNJclust, and IPCAPS frameworks. 
 
The package also provides a function to retrieve phylogeny tree that construct a neighbor-joining tree based on a similar matrix between clusters. 

By given multiple Q matrices with varying a number of ancestors (K), the framework define a similar value between clusters i,j as a minimum number K* that makes majority of members of two clusters are in the different clusters. This K* reflexes a minimum number of ancestors we need to splitting cluster i,j into different clusters if we assign K* clusters based on maximum admixture ratio of individuals.
 

Installation
------------

For the newest version on github, please call the following command in R terminal.

``` r
remotes::install_github("DarkEyes/ipADMIXTURE")
```
This requires a user to install the "remotes" package before installing ipADMIXTURE.

EXAMPLE
----------------------------------------------------------------------------------

In this example, we have data set of human 27 population data published by Xing, J., et al. (2009). The dataset consists of 544 individuals from 27 populations. The Q matrices from this data are provided in this package. The following steps are the simple way to use our package.


Step1: running the  ipADMIXTURE using Human 27 population dataset where the number of ancestors K =12. 
```{r}
library(ipADMIXTURE)
# # running area: ipADMIXTURE::human27pop_Qmat[[i]] is a Q matrix with K=i+1
h27pop_obj<-ipADMIXTURE(Qmat=ipADMIXTURE::human27pop_Qmat[[11]], admixRatioThs =0.15)
```

Step2: printing all cluster information in text mode.
```{r}
ipADMIXTURE::printClustersFromLabels(h27pop_obj,human27pop_labels)
```

Then, the text looks like this
```{r}
[1] "Overall labels"
[1] "==============="
[1] "Alur(10)Hema(15)Pygmy(25)Brahmin(25)Utah_N._European(25)Cambodian(5)Chinese(10)Tamil_LC(13)Irula(24)JPN2(13)Madiga(10)Mala(11)CEU(60)YRI(60)CHB(45)JPT(45)Luhya(24)Tuscan(25)Kung(13)Pedi(10)Sotho/Tswana(8)Stalskoe(5)Iban(25)TBrahmin(14)Urkarah(18)VN(7)Nguni(9)"
[1] "==============="
[1] "ID1, md0.05, N25"
[1] "Pygmy(25/25)"
[1] "==============="
[1] "ID2, md0.13, N56"
[1] "JPN2(12/13)JPT(44/45)"
[1] "==============="
[1] "ID3, md0.00, N12"
[1] "Kung(12/13)"
[1] "==============="
[1] "ID4, md0.00, N25"
[1] "Iban(25/25)"
[1] "==============="
[1] "ID5, md0.00, N69"
[1] "Cambodian(5/5)Chinese(10/10)JPN2(1/13)CHB(45/45)JPT(1/45)VN(7/7)"
[1] "==============="
[1] "ID6, md0.06, N25"
[1] "Utah_N._European(1/25)Tuscan(24/25)"
[1] "==============="
[1] "ID7, md0.09, N85"
[1] "Utah_N._European(24/25)CEU(60/60)Tuscan(1/25)"
[1] "==============="
[1] "ID8, md0.00, N17"
[1] "Urkarah(17/18)"
[1] "==============="
[1] "ID9, md0.00, N6"
[1] "Stalskoe(5/5)Urkarah(1/18)"
[1] "==============="
[1] "ID10, md0.00, N4"
[1] "Irula(4/24)"
[1] "==============="
[1] "ID11, md0.00, N10"
[1] "Irula(10/24)"
[1] "==============="
[1] "ID12, md0.00, N9"
[1] "Irula(9/24)"
[1] "==============="
[1] "ID13, md0.00, N33"
[1] "Tamil_LC(13/13)Madiga(9/10)Mala(11/11)"
[1] "==============="
[1] "ID14, md0.08, N41"
[1] "Brahmin(25/25)Irula(1/24)Madiga(1/10)TBrahmin(14/14)"
[1] "==============="
[1] "ID15, md0.00, N4"
[1] "Pedi(2/10)Sotho/Tswana(2/8)"
[1] "==============="
[1] "ID16, md0.00, N20"
[1] "Pedi(5/10)Sotho/Tswana(6/8)Nguni(9/9)"
[1] "==============="
[1] "ID17, md0.00, N4"
[1] "Kung(1/13)Pedi(3/10)"
[1] "==============="
[1] "ID18, md0.04, N60"
[1] "YRI(60/60)"
[1] "==============="
[1] "ID19, md0.00, N4"
[1] "Hema(2/15)Luhya(2/24)"
[1] "==============="
[1] "ID20, md0.00, N2"
[1] "Luhya(2/24)"
[1] "==============="
[1] "ID21, md0.07, N20"
[1] "Luhya(20/24)"
[1] "==============="
[1] "ID22, md0.12, N23"
[1] "Alur(10/10)Hema(13/15)"
```
For any cluster, it is separated from other cluster by "===============". The first line of cluster details is "IDx, md0.xx, Nx" and the second line is a detail of populations from the ground truth. 

For example,
[1] "ID19, md0.00, N4"
[1] "Hema(2/15)Luhya(2/24)".

This is a cluster ID19 that has a maximum of manitude-difference of admixture ratios (md) as 0.00 and there are 4 individuals in this cluster. For a second line, there are 2 individuals from Hema population where the total number of Hema members is 15. There are also 2 individuals out of 24 from Luhya population.


Step3: plotting admixture ratios and clustering assignment.

```{r}
ipADMIXTURE::plotAdmixClusters(h27pop_obj)
```
<img src="https://github.com/DarkEyes/ipADMIXTURE/blob/master/man/FIG/admix.png" width="550">

Step4: plotting clustering information in treemap plot

```{r}
ipADMIXTURE::plotClusterLeaves(h27pop_obj)
```
<img src="https://github.com/DarkEyes/ipADMIXTURE/blob/master/man/FIG/treemap.png" width="550">

Step5: Inferring phylogenetic tree of clusters based on a list of Q matrices that varies K using neighbor-joining (NJ) method. 

```{r}
out<-ipADMIXTURE::getPhyloTree(human27pop_Qmat,h27pop_obj$indexClsVec)
plot(out$tree,type = "unrooted")
```
<img src="https://github.com/DarkEyes/ipADMIXTURE/blob/master/man/FIG/nj.png" width="400">

The leave nodes are cluster IDs. 

Creating Q matrix from .geno file using R
---------------------------------------------------
There are two well-known software to get Q matrix: <a href="http://software.genetics.ucla.edu/admixture/">ADMIXTURE</a>  and <a href="https://web.stanford.edu/group/pritchardlab/structure.html">STRUCTURE</a>. However, if you want to have everything in R, then here's the solution.

We can use <a href="https://www.bioconductor.org/packages/release/bioc/html/LEA.html">LEA package</a> to convert .geno file into Q matrix. If you never install bioconductor, then you should run the following code.
```{r}
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
```
You can install LEA package by the BiocManager below.
```{r}
BiocManager::install("LEA")
```
Suppose we have "yourfile.geno" and we want to get the Q matrix with 4 ancestors, then we can run the following code.
```{r}
library(LEA)
obj.snmf = LEA::snmf(input.file="yourfile.geno", K = 4, project = project, iterations= iterations)
 Qmat = LEA::Q(obj.snmf, K = K)
```

Citation
----------------------------------------------------------------------------------
- ipADMIXTURE: R package for inferring sub-population clusters based on genetic admixture
Chainarong Amornbunchornvej, Pongsakorn Wangkumhang, Sissades Tongsima
bioRxiv 2020.03.21.001206; doi: https://doi.org/10.1101/2020.03.21.001206

Contact
----------------------------------------------------------------------------------
- Developer: C. Amornbunchornvej<div itemscope itemtype="https://schema.org/Person"><a itemprop="sameAs" content="https://orcid.org/0000-0003-3131-0370" href="https://orcid.org/0000-0003-3131-0370" target="orcid.widget" rel="noopener noreferrer" style="vertical-align:top;"><img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon">https://orcid.org/0000-0003-3131-0370</a></div>
- <a href="https://www.nectec.or.th/en/research/dsaru/dsarg-sai.html">Strategic Analytics Networks with Machine Learning and AI (SAI)</a>, <a href="https://www.nectec.or.th/en/">NECTEC</a>, Thailand
- Homepage: <a href="https://sites.google.com/view/amornbunchornvej/home">Link</a>
