% P R O Y E C T O   1







% Modelo 1. 







clear all;
close all;
clc;
%% Cargar los datos
data = xlsread('Datos_Proyecto2.xls', 'datos'); %Carga los datos del archivo
TEST1 = xlsread('Datos_Proyecto2.xls', 'prediccion'); %Carga los datos del archivo

%% Limpieza de datos
data = data(logical(1-sum(isnan(data),2)),:); % Eliminar todas las filas que contengan NaN
%Normalización de datos
for i=1:size(data,2)-1
     TEST1(:,i) = (TEST1(:,i)-mean(data(:,i)))/std(data(:,i));
     data(:,i) = (data(:,i)-mean(data(:,i)))/std(data(:,i)); % Lo estandarizamos debido a que tenemos variables muy grandes y otras muy pequeñas. 
end

%%
%Matriz de correlación
Correlacion = corr(data(:,1:end-1));

%%
X1 = data(:,[1 2 3 4 7 9]); 
TEST1 = TEST1(:,[1 2 3 4 7 9]);
Y1 = data(:,end);

%% Regresión Logística 
ngrado1 = 4;
X1a=func_polinomio(X1,ngrado1);
W1=zeros(size(X1a,2),1); %Pesos iniciales %iniciar de ceros (tamaño(xa, num columnas),en columna)
[J,dJdW]=fun_costob(W1,X1a,Y1); %Calculo de J y W

options=optimset('GradObj','on','MaxIter',1000);
[Wopt1,Jopt]=fminunc(@(W)fun_costob(W,X1a,Y1),W1,options);

% %% TRAIN 
V1=X1a*Wopt1;
Yg_train1=1./(1+exp(-V1));
Yg_train1=round(Yg_train1); %Redondea a unos y ceros pero deja en números

[Accu_train, Prec_train, Rec_train] = desempenio(Yg_train1,Y1) % Desempenio.
% %% Graficar matriz de confusión
confmat_train = confusionmat(Y1, Yg_train1)
confusionchart(confmat_train)

%% TEST 
V1=func_polinomio(TEST1,ngrado1)*Wopt1;
Yg_test1=1./(1+exp(-V1));

Yg_test1=round(Yg_test1)
%%








% Modelo 2. 









%% Cargar los datos
data = xlsread('Datos_Proyecto2.xls', 'datos'); %Carga los datos del archivo
TEST2 = xlsread('Datos_Proyecto2.xls', 'prediccion'); %Carga los datos del archivo

%% Limpieza de datos
data = data(logical(1-sum(isnan(data),2)),:); % Eliminar todas las filas que contengan NaN
%Normalización de datos
for i=1:size(data,2)-1
     TEST2(:,i) = (TEST2(:,i)-mean(data(:,i)))/std(data(:,i));
     data(:,i) = (data(:,i)-mean(data(:,i)))/std(data(:,i)); % Lo estandarizamos debido a que tenemos variables muy grandes y otras muy pequeñas. 
end

%%
%Matriz de correlación
Correlacion = corr(data(:,1:end-1));

%%
X2 = data(:,[1 2 3 7 9]); 
TEST2 = TEST2(:,[1 2 3 7 9]);
Y2 = data(:,end);

%% Regresión Logística 
ngrado2 = 4;
X2a=func_polinomio(X2,ngrado2);
W2=zeros(size(X2a,2),1); %Pesos iniciales %iniciar de ceros (tamaño(xa, num columnas),en columna)
[J,dJdW]=fun_costob(W2,X2a,Y2); %Calculo de J y W

options=optimset('GradObj','on','MaxIter',1000);
[Wopt2,Jopt]=fminunc(@(W)fun_costob(W,X2a,Y2),W2,options);

% %% TRAIN 
V2=X2a*Wopt2;
Yg_train2=1./(1+exp(-V2));
Yg_train2=round(Yg_train2); %Redondea a unos y ceros pero deja en números

[Accu_train, Prec_train, Rec_train] = desempenio(Yg_train2,Y2) % Desempenio.
% %% Graficar matriz de confusión
confmat_train = confusionmat(Y2, Yg_train2)
confusionchart(confmat_train)

%% TEST 
V2=func_polinomio(TEST2,ngrado2)*Wopt2;
Yg_test2=1./(1+exp(-V2));

Yg_test2=round(Yg_test2)
%%







% Modelo 3. 









%% Cargar los datos
data = xlsread('Datos_Proyecto2.xls', 'datos'); %Carga los datos del archivo
TEST3 = xlsread('Datos_Proyecto2.xls', 'prediccion'); %Carga los datos del archivo

%% Limpieza de datos
data = data(logical(1-sum(isnan(data),2)),:); % Eliminar todas las filas que contengan NaN
%Normalización de datos
for i=1:size(data,2)-1
     TEST3(:,i) = (TEST3(:,i)-mean(data(:,i)))/std(data(:,i));
     data(:,i) = (data(:,i)-mean(data(:,i)))/std(data(:,i)); % Lo estandarizamos debido a que tenemos variables muy grandes y otras muy pequeñas. 
end

%%
%Matriz de correlación
Correlacion = corr(data(:,1:end-1));

%%
X3 = data(:,[3 7 9]); 
TEST3 = TEST3(:,[3 7 9]);
Y3 = data(:,end);

%% Regresión Logística 
ngrado3 = 4;
X3a=func_polinomio(X3,ngrado3);
W3=zeros(size(X3a,2),1); %Pesos iniciales %iniciar de ceros (tamaño(xa, num columnas),en columna)
[J,dJdW]=fun_costob(W3,X3a,Y3); %Calculo de J y W

options=optimset('GradObj','on','MaxIter',1000);
[Wopt3,Jopt]=fminunc(@(W)fun_costob(W,X3a,Y3),W3,options);

% %% TRAIN 
V3=X3a*Wopt3;
Yg_train3=1./(1+exp(-V3));
Yg_train3=round(Yg_train3); %Redondea a unos y ceros pero deja en números

[Accu_train, Prec_train, Rec_train] = desempenio(Yg_train3,Y3) % Desempenio.
% %% Graficar matriz de confusión
confmat_train = confusionmat(Y3, Yg_train3)
confusionchart(confmat_train)

%% TEST 
V3=func_polinomio(TEST3,ngrado3)*Wopt3;
Yg_test3=1./(1+exp(-V3));

Yg_test3=round(Yg_test3)