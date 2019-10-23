%Crear funcion de costo 
%calculo la J y la derivada de J con respecto a W

function[J, dJdW] = fun_costo(W, Xa, Y)


V = Xa*W;
Yg = 1./(1 + exp(-V)); %Y estimada

n = size(Xa, 1); %Elementos en X

J = sum(-Y.*log(Yg) - (1 - Y).*log(1 - Yg))/n;
%Funcion de costo Perceptron

E = Yg - Y;
dJdW = (E'*Xa)'/n; %Derivada

end


