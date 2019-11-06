%Función de costo calcula la J y la dJdW para la
%regresión logística
%[J,dJdW]=fun_costo(W,Xa,Y)
function [J,dJdW]=fun_costob(W,Xa,Y)

V=Xa*W;
Yg=1./(1+exp(-V)); %Y estimada

n=size(Xa,1); %Cantidad de elementos

J=sum(-Y.*log(Yg)-(1-Y).*log(1-Yg))/n
%función de costo del Perceptrón

E=Yg-Y; %Error
dJdW=(E'*Xa)'/n; %Derivada de J respecto a W
end
