df=read.csv("X.csv",row.names = 1,header=T)
df=df[,2:(dim(df)[2]-1)] #exclude age(1st column) and gender(last column)

df.colname=read.csv("diseased_or_not.csv",row.names = 1)
df.colname=as.numeric(as.matrix(df.colname))


pvals=c()
for(col in df){
  normal=col[df.colname]
  diseased=col[df.colname==0]
  pval=t.test(normal,diseased,alternative="two.sided")$p.value
  pvals=c(pvals,pval)
}



write.csv(pvals,file="pvals.csv",row.names = F)
