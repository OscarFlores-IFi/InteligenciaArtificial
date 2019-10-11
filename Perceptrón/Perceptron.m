clear all;
close all;
clc;

%% Cargar los datos
load data1.txt; %carga los datos del archivo
data=data1;

X=data(:,1:2);
Y=data(:,3);
n=size(X,1); %Cantidad de datos
%% Graficado de datos (Se debe BORRAR)
G0=data(data(:,3)==0,1:2); %Grupo 0
G1=data(data(:,3)==1,1:2); %Grupo 1

plot(G0(:,1),G0(:,2),'bo',G1(:,1),G1(:,2),'rx')

%% Regresi?n Log?stica

%Xa=[ones(n,1) X X.^2];
Xa=func_polinomio(X,2);

W=zeros(size(Xa,2),1); %Pesos iniciales
[J,dJdW]=fun_costob(W,Xa,Y); %Calculo de J y W

options=optimset('GradObj','on','MaxIter',1000);

[Wopt,Jopt]=fminunc(@(W)fun_costob(W,Xa,Y),W,options);

%% Simulaci?n del modelo obtenido
V=Xa*Wopt;
Yg=1./(1+exp(-V));
Yg=round(Yg);

[Accu Prec Rec] = desempenio(Yg,Y)

%% dibujar la frontera de separaci?n (BORRARSE)
x1=30:.1:100;
x2=30:.1:100;
[x1,x2]=meshgrid(x1,x2); %todas las combinaciones
%entre x1 y x2
[m,n]=size(x1);
x1temp=reshape(x1,m*n,1); %Reordena en vector
x2temp=reshape(x2,m*n,1); %Reordena en vector
Xtemp=[x1temp x2temp];
%Xatemp=[ones(m*n,1) x1temp x2temp x1temp.^2 x2temp.^2];
Xatemp=func_polinomio(Xtemp,2);
Ytemp=Xatemp*Wopt;
Ytemp=reshape(Ytemp,m,n);

plot(G0(:,1),G0(:,2),'bo',G1(:,1),G1(:,2),'rx')
hold on;
contour(x1,x2,Ytemp,[0 0],'LineWidth',2);
hold off;






