%% Repaso Parcial 3.


%% Problema 1
clear
clc
load house.mat

X = house(1:end-1,:)
Y = house(end,:)

%% Seleccion de datos de entrenamiento
ndat = round(0.9*size(Y,2));

Xtrain = X(:,1:ndat);
Ytrain = Y(:,1:ndat);

Xtest = X(:,ndat+1:end);
Ytest = Y(:,ndat+1:end);

%% Entrenamiento
% red=feedforwardnet([10 5 10]);

red.trainFcn='trainlm'
red=train(red,Xtrain,Ytrain);

Ygtest = red(Xtest); 
Yg = red(X)

scatter(Yg, Y, 'k*') %Graficamos los datos predichos vs los reales. 
xlabel('Yg')
ylabel('Y')
title('Yg vs Y')
hold on
scatter(Ygtest, Ytest, 'ro')
hold off
perform(red,Y,Yg)
perform(red,(Ygtest),Ytest)
%% Valuación de una casa basado en los parametros específicados. 
X1= 12.54
X2=45
X3=15.37
X4=1
X5=0.5150
X6=6.1621
X7=45.800
X8=3.3751
X9=7
X10=193
X11=15.200
X12=347.88
X13=2.96

pred = [X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13]';
estimacion = red(pred)


%% Problema 2
clear
clc
load ex_mia4_data1.mat

data=train';
clear train

X=data(1:end-1,:);
Y=data(end,:);

ndat=round(size(Y,2)); %Cantidad de datos para entrenar
% ndat=round(0.85*size(Y,2)); %Cantidad de datos para entrenar (85%)

Ytrain=Y(1:ndat);
Xtrain=X(:,1:ndat);

%% Creaci?n del modelo neuronal
red=feedforwardnet([]);
red.trainFcn='trainrp' % se puede usar 'trainscg' o 'trainrp'
red=train(red,Xtrain,Ytrain);

%% Simulaci?n
Yg=round(red(X));
pred = round(red(test_unknown'))












