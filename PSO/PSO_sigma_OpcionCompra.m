%% Se estima la volatilidad de un activo del cual se
% conoce un spot price, valor pactado en una opción, tiempo de la opción
% precio de la opcion, tasa de interés y plazo.

%Limpieza General
clear all; clc; close all;
%%
% sig=.01 %Sigma

So=20; %Precio Spot
X=21; %Precio a predecir
r=.10; %Tasa
t=5; %Tiempo o plazo
price=12; % Precio de una opción de compra


rand_=rand(100000,2);%Aleatorio 1 y 2
BM=cos(2*pi*rand_(:,1)).*(-2*log(rand_(:,2))).^0.5;%BoxMuller
%%
np=32; %Número de particulas
c1=0.04; %velocidad de convergencia al mejor global
c2=0.04; %velocidad de convergencia al mejor local


xp=rand(np,1); %La posición de inicio de cada particula.Genera aleatorios en una columna
xpg=0; %La posición inicial del mejor global
xpL=xp; %Valores iniciales de los mejores locales
vx=zeros(np,1); %velocidad inicial de cada particula

fx=zeros(np,1);
fxpg=1000000; %desempeño inicial del mejor global
fxpL=ones(np,1)*fxpg; %desempeño inicial de los Locales 

for k=1:1000
    for n=1:np
        St=So*(exp(((r-(xp(n)^2)/2)*t)+(xp(n)*BM*(t^.5))));
        FSt=St-X;
        promFSt=mean(FSt);
        fx(n)=abs(promFSt-price)-10000000*min(xp(n),0); %función de desempeño
    end
   
    [val,ind]=min(fx); %Mínimo de la función y su posición
    %Determinar el mejor global
    if val<fxpg
        xpg=xp(ind,1);
        fxpg=val;
    end
 
    %Determinar los mejores locales
    for p=1:np %Para cada particula
        if fx(p,1)<fxpL(p,1) %Compara el desempeño con el mejor local
            fxpL(p,1)=fx(p,1); %Actulaiza el desmpeño
            xpL(p,1)=xp(p,1); %Actualiza Posición

        end
    end
    
    %%
    vx=vx+c1*rand()*(xpg-xp)+c2*rand()*(xpL-xp); %%Nueva velocidad
    xp=xp+vx; %Nueva Posición
    
    %% Pa' graficar
    plot(xpg,fxpg,'r*',xp,fx,'b.')
    pause(0.0025)
end
    
disp([xpg, fxpg])
