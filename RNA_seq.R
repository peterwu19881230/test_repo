#BiocManager::install("RankProd")
library(RankProd)
library(dplyr)

pfp_cutoff=0.05

df=read.csv("https://github.com/peterwu19881230/test_repo/raw/master/Norm_NR.csv",header=1)
df=df[,-(1:3)]
df.colname=ifelse(grepl("CDA",colnames(df)),1,0)

start.time = Sys.time()
RP.out = RankProducts(df,df.colname, logged=TRUE,  na.rm=FALSE,plot=FALSE, rand=123)
end.time = Sys.time()
end.time - start.time #Time difference of 4.103169 mins

result=topGene(RP.out,cutoff=0.05,method="pfp",logged=TRUE,logbase=2,gene.names=NULL)

diff_gene_index=unique(c(result[[1]][,"gene.index"],result[[2]][,"gene.index"]))
length(diff_gene_index)

write.csv(diff_gene_index,file="diff_gene_index.csv",row.names = F)



