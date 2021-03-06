data = readtable('D_limpio.csv');
data = data(~sum(isnan(data{:,:}),2),:);


% Cuantitativos
income = data.income;
age = data.age;
score = data.score;
total_debt = data.total_debt;
amount_to_be_lend = data.amount_to_be_lend;

% Cualitativos
gender = [data.F data.M];
housing_type = [data.FAMILIA data.PROPIO data.RENTADO];
level_of_studies = [data.Licenciatura data.Posgrado data.Preparatoria];
marital_status = [data.CASADO data.DIVORCIADO data.SEPARADO data.SOLTERO data.UNION_LIBRE data.VIUDO];

X1 = [income age score total_debt amount_to_be_lend];
X2 = [gender housing_type level_of_studies marital_status];
X3 = [income score total_debt amount_to_be_lend level_of_studies gender housing_type];
X4 = [income age score total_debt amount_to_be_lend gender housing_type level_of_studies marital_status];

%% Estandarizamos las X 

for k=1:4
    eval(sprintf('s = size(X%d,2)',k))
    for i=1:s
        eval(sprintf('X%d(:,i) = (X%d(:,i)-mean(X%d(:,i)))/std(X%d(:,i))',k,k,k,k))
        
    end
end

Y = data.APPROVED;

%% X asterisco
for k=1:2
    ngrado = k;
    for i=1:4
        eval(sprintf('X.m%dg%d = func_polinomio(X%d,ngrado)',i,ngrado,i));
    end
end

%% Adaline 
for k=1:2
    ngrado = k;
    for i=1:4
        eval(sprintf('Wadaline.m%dg%d = pinv(X.m%dg%d''*X.m%dg%d)*X.m%dg%d''*Y',i,ngrado,i,ngrado,i,ngrado,i,ngrado))
    end
end

%% Perceptrón
for k=1:2
    ngrado = k;
    for i=1:4
    eval(sprintf('Xa=X.m%dg%d',i,k));
    W=zeros(size(Xa,2),1); %Pesos iniciales
    [J,dJdW]=fun_costob(W,Xa,Y); %Calculo de J y W
    options=optimset('GradObj','on','MaxIter',1000);
    eval(sprintf('[Wperceptron.m%dg%d,Jopt]=fminunc(@(W)fun_costob(W,Xa,Y),W,options);',i,k));
    
%     eval(sprintf('Yg.m%dg%d = 1./(1+exp(-(X.m%dg%d*Wperceptron.m%dg%d)));',i,k,i,k,i,k)); % Sin redondear
    eval(sprintf('Yg.m%dg%d = round(1./(1+exp(-X.m%dg%d*Wperceptron.m%dg%d)));',i,k,i,k,i,k)); % Redondeados
        
    eval(sprintf('[Accu Prec Rec] = desempenio(Yg.m%dg%d,Y);',i,k)); % Sin redondear
    eval(sprintf('Desempenio.m%dg%d = [Accu Prec Rec];',i,k)); % Sin redondear
    end
end
%% Competitivas 
nneuronas = [5 10 15 25 40 65 105];

for i=1:4
    Jcost = zeros(size(nneuronas));
    NNN = zeros(size(nneuronas));
    for iter=1:size(nneuronas,2)
        eval(sprintf('data = X.m%dg%d',i,1))
        data = data';
        neuronas = nneuronas(iter);
        red = competlayer(neuronas);
        red.trainParam.epochs = 1000;
        red = train(red,data) ;
        eval(sprintf('Red.m%d.n%d = red',i,neuronas))
        
        % Calculo de J 
        [J, nnn] = CalculoJ(data,red);

        Jcost(iter) = J;
        NNN(iter) = nnn;
    end
    eval(sprintf('FuncCosto.m%d = Jcost',i))
    eval(sprintf('Nfinal.m%d = NNN',i))
end

%% Guardar modelos
save Digitt.mat
