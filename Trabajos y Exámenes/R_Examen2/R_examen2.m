
%% ########################################################################
%  ############################## Problema 1 ##############################
%  ########################################################################

% Cargamos datos de entrenamiento
data = xlsread('CCPP.xlsx'); %Carga los datos del archivo

% Cargamos datos para predicción
AT=21.42
AP=1015.76
RH=43.08
V=43.79
Test = [AT V AP RH]

%% Adaline no estandarizado 
% Separamos datos de modelo no estandarizado
X = data(:,1:end-1);
Y = data(:,end);

% Entrenamos modelo
W = pinv(X'*X)*X'*Y;

% Probamos modelo 
Pred = Test*W



%% Adaline estandarizado 
% Estandarizamos los datos 
data_norm = zeros(size(data));

Mu = mean(data,1)
Std = std(data)
Test(5) = 1;
Test_norm = ones(1,size(Test,2));
for i=1:size(data,2)
    data_norm(:,i) = (data(:,i)-Mu(i))/Std(i);  
    Test_norm(i) = (Test(i)-Mu(i))/Std(i);
end
Test(5) = [];
Test_norm(5) = [];

Xnorm = data_norm(:,1:end-1);
Ynorm = data_norm(:,end);

Wnorm = pinv(Xnorm'*Xnorm)*Xnorm'*Ynorm;

Pred_norm = Test_norm*Wnorm*Std(end)+Mu(end)


%% ########################################################################
%  ############################## Problema 2 ##############################
%  ########################################################################

