%% Problema 1

% Cargamos datos de entrenamiento
data = xlsread('CCPP.xlsx'); %Carga los datos del archivo

% Cargamos datos para predicción
AT=21.42
AP=1015.76
RH=43.08
V=43.79
TEST = [AT V AP RH]

%% Adaline no estandarizado 
% Separamos datos de modelo no estandarizado
X = data(:,1:end-1);
Y = data(:,end);

ngrado = 1;
Xa = func_polinomio(X,ngrado);

% Entrenamos modelo
W = pinv(Xa'*Xa)*Xa'*Y;

% Probamos modelo 
Test = func_polinomio(TEST, ngrado);
Pred = Test*W


%% Adaline no estandarizado 2
% Separamos datos de modelo no estandarizado
X = data(:,1:end-1);
Y = data(:,end);

ngrado = 2;
Xa = func_polinomio(X,ngrado);

% Entrenamos modelo
W = pinv(Xa'*Xa)*Xa'*Y;

% Probamos modelo 
Test = func_polinomio(TEST, ngrado);
Pred = Test*W

%% Problema 2
clear
clc
data = xlsread('Datainmuno.xlsx'); %Carga los datos del archivo
test = data((sum(isnan(data),2)==1),1:end-1)
data = data(not(sum(isnan(data),2)>0),:)

X = data(:,1:end-1)
Y = data(:,end)

% Regresión logística. 
ngrado = 1
Xa=func_polinomio(X,ngrado);
Test = func_polinomio(test,ngrado); 

W=zeros(size(Xa,2),1); %Pesos iniciales
[J,dJdW]=fun_costob(W,Xa,Y); %Calculo de J y W

options=optimset('GradObj','on','MaxIter',1000);

[Wopt,Jopt]=fminunc(@(W)fun_costob(W,Xa,Y),W,options);

% Simulaci?n del modelo obtenido
V=Xa*Wopt;
Yg=1./(1+exp(-V));
Yg=round(Yg);

[Accu Prec Rec] = desempenio(Yg,Y)
confusionchart(confusionmat(Yg,Y))

%%
pred = 1./(1+exp(-Test*Wopt))
% 
% pred =
% 
%     0.9183
%     0.9383
%     0.9588

%% Problema 3 
clc;
clear all;
close all;

data = xlsread('KnowledgeModeling.xls', 'Training_Data' )
data = data';

%% Entrenamiento de la red. 
Iteraciones = 10

Jcost = zeros(Iteraciones,1);
NNN = zeros(Iteraciones,1);
for iter=2:size(Jcost)+1
    neuronas = iter;
    red = competlayer(neuronas);
    red.trainParam.epochs = 100;
    red = train(red,data) ;
    
    % Calculo de J 
    [J, i] = CalculoJ(data,red)
    Jcost(iter-1) = J
    NNN(iter-1) = i
end
%%
plot([2:Iteraciones+1],Jcost)
%%
plot([2:Iteraciones+1],NNN)
%% Elejimos cantidad de Neuronas para la clasificación. 

neuronas = 5; %cambiar de acuerdo a grafica de codo
red = competlayer(neuronas);
red.trainParam.epochs = 1000; 
red = train(red,data) ;

% Probar el modelo con los datos. 
Y = vec2ind(red(data))
grupos = unique(Y)

%% Calculo de J 
[J,i] = CalculoJ(data,red) % i es la cantidad de neuronas que fueron utilizadas. 


