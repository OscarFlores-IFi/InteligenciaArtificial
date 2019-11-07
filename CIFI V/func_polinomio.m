function [Xp,coef]=func_polinomio (X,ngrado) 
% Funci?n que crea una matriz con los valores recibidos en X y los eleva a
% la potencia ngrado. Los resultados los regresa como una matriz con la
% estructura siguiente [1 x1 x2 x1x2 x1^2 x2^2 ....]
%
% Xp=func_polinomio (X,ngrado)

Xp=ones(size(X,1),1);
nvar=size(X,2);
coef=zeros(1,nvar);

for g=1:ngrado
    % Obtener la tabla de coeficientes
    Atemp=[[g-1:-1:1]' [1:1:g-1]'];
    A=[];
    for i=1:nvar-1
        for j=i+1:nvar
            Btemp=zeros(g-1,nvar);
            Btemp(:,i)=Atemp(:,1);
            Btemp(:,j)=Atemp(:,2);
            A=[A; Btemp];
        end
    end 
    A=[A;g*eye(nvar)];
 
    %%% elevar al grado ngrado
    for k=1:size(A,1)
        temp=ones(size(X,1),1);
        for j=1:nvar
            temp=temp.*(X(:,j).^A(k,j));
        end
        Xp=[Xp temp];
    end 
    %%%%%%%%%%%%%%%%%%%
    coef=[coef;A];
end
coef=coef';