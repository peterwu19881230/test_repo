import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)

## line 1066 has misterious values -> ignored those values
expression=pd.read_table("Adjusted_expression_values.txt",index_col=0,usecols=list(range(0,547))).T
expression.index=expression.index.astype('int64')

individuals=pd.read_table("E-MTAB-8018.sdrf.txt",index_col=0)



df=individuals.join(expression,how='inner')

#Columns in addition to gene expression I think should remain in the model: sex (column 2, 0 indexed), age (column 3, 0 indexed)
col_in_model=[2,3]
col_in_model.extend(list(range(28,47311)))
X=df.iloc[:,col_in_model]
X=pd.get_dummies(X) #get dummy variables for (male,female)

#response variable (target)
y=np.array(df['Characteristics[disease]'])




#impute NA by mean of each feature 
from sklearn.impute import SimpleImputer

def impute_by_mean(data):
    imp_mean = SimpleImputer(missing_values=np.nan, strategy='mean') 
    imp_mean.fit(data)
    return(pd.DataFrame(imp_mean.transform(data)))

X=impute_by_mean(X) 


X.to_csv('X.csv')

diseased_or_not=pd.DataFrame(np.where(y!='normal',1,0))
diseased_or_not.to_csv('diseased_or_not.csv')

