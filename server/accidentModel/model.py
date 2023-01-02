import numpy as np
import pandas as pd
import sys
import math
import os

finalPredictionArray=[]

path_location = os.path.dirname(__file__) + "/Data.csv"
dataset=pd.read_csv(path_location)
X=dataset.iloc[:,:-1].values
y=dataset.iloc[:,-1].values

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)

from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression
poly_reg = PolynomialFeatures(degree = 4)
X_poly = poly_reg.fit_transform(X_train)
regressor = LinearRegression()
regressor.fit(X_poly, y_train)

y_pred=regressor.predict(poly_reg.transform(X_test))
np.set_printoptions(precision=3)
#print(np.concatenate((y_pred.reshape(len(y_pred),1),y_test.reshape(len(y_test),1)),1))

from sklearn.metrics import r2_score
#print(r2_score(y_test, y_pred))

#print('The order of preference is: ')
order=sorted(y_pred,reverse=True)
#print(order[0:5])

################################################################################################
#Reading the inputs 

lines = sys.stdin.readline()

importantDataArray=[]

# Parameters
place=1001
population=175
radius=100
time_=float(lines)

avg_pr=5
covid=12

for r in range(9):
	for k in range(10):
		finalPredictionArray.append(regressor.predict(poly_reg.fit_transform([[(1000+r+1),dataset['Population'].iloc[r*720+k*72+math.ceil(time_*72)],radius*(k+1),time_,dataset['Average Priority Of accident'].iloc[r*720+k*72+math.ceil(time_*72)],dataset['Covid Cases'].iloc[r*720+k*72+math.ceil(time_*72)]]]))[0] * (dataset['Average Priority Of accident'].iloc[r*720+k*72+math.ceil(time_*72)]) + (0.00001*dataset['Covid Cases'].iloc[r*720+k*72+math.ceil(time_*72)]) )
finnparray = np.array(finalPredictionArray)
idx = np.argpartition(finnparray, -10)[-10:]
indiceList = idx[np.argsort((-finnparray)[idx])]
populationRadiusCombination =[]

for r in range(len(indiceList)):
	tens=math.floor((indiceList[r])/10)
	ones=(indiceList[r])%10
	populationRadiusCombination.append([tens,100*(ones+1)])

print(populationRadiusCombination)
sys.stdout.flush()
