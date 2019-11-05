import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from mylib import mylib
from sklearn.preprocessing import PolynomialFeatures


#%%
Data = pd.read_csv('Digitt.csv',index_col='id')
data = Data.iloc[:,0:20]
data = data.join(Data.rate_0).join(Data.loan_amount_0)
data.amount_to_be_lend[np.isnan(data.amount_to_be_lend)] = data.total_debt[np.isnan(data.amount_to_be_lend)] # llenamos todos los nan faltantes en amount_to_be_lend con los total_debt (ya que usualmente asi se comportan.)
#plt.hist(data.age,bins=20) # Edad de las personas que piden el servicio
#plt.hist(data.score,bins=20) # el 'score' esta distribuido de forma casi plana. 
#pd.value_counts(data.status).plot(kind='bar') # Se acepta casi a la mitad de las personas que solicitan el servicio
reporte = mylib.dqr(data)
#%% Para Status. Accepted vs Rejected. 
# Limpieza de base de datos. 
stat = data.drop(columns=['reasson', 'payment_status','created_at'])
sts = mylib.dqr(stat)

Quant = stat.loc[:,['income', 'age', 'score','icc', 'tenure','rate', 'total_debt', 'amount_to_be_lend']]
#Dummies = stat.loc[:,['gender', 'housing_type','occupancy_type','level_of_studies','state','marital_status']]
Dummies = stat.loc[:,['gender', 'housing_type','occupancy_type','level_of_studies','marital_status']]
Y = pd.get_dummies(stat.status)

#%% Creamos Dummies.
# uniques 
n = Dummies.shape[1]
uq = np.zeros(n+1)
for i in np.arange(n):
    uq[i+1] = len(pd.unique(Dummies.iloc[:,i]))-1
uq = uq.cumsum().astype(int)
#2630
#prestadero
#
#llenamos matriz con dummies. 
mat = pd.get_dummies(Dummies.iloc[:,0])
for i in np.arange(1,n):
    mat = mat.join(pd.get_dummies(Dummies.iloc[:,i]))

Dummies = mat
#%% Unimos todas las variables y las exportamos a un csv 'limpio'
limpio = Quant.join(Dummies).join(Y)
limpio.to_csv('D_limpio.csv')
