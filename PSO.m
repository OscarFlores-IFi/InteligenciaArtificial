clear all;
close all;
clc;
 
np=300; %Número de particulas
 
 x1p=rand(np,1); %La posición de inicio de cada particula
 x1pg=0; %La posici?n inicial del mejor global
 x1pL=x1p; %valores iniciales de los mejores locales
 vx1=zeros(np,1); %velocidad inicial de cada particula
  
 x2p=rand(np,1); %La posici?n de inicio de cada particula
 x2pg=0; %La posici?n inicial del mejor global
 x2pL=x2p; %valores iniciales de los mejores locales
 vx2=zeros(np,1); %velocidad inicial de cada particula
 
 fxpg=1000000; %desempe?o inicial del mejor global
 fxpL=ones(np,1)*fxpg; %desempe?o inicial de los Locales
 
 c1=.02; %Velocidad de convergencia al mejor global 
 %c1*aleatorio*c2*aleatorio<=3.8
 c2=.02; %velocidad de convergencia al mejor local
 a=1000; %Penalizaci?n
 
 for k=1:1000
     %fx=20+x1p.^2-10*cos(2*pi*x1p)+x2p.^2-10*cos(2*pi*x2p); %Funci?n de desempe?o
     fx= (0.05^(1/2)*x1p.^2 + 0.05^(1/2)*x2p.^2 ) + ...
         a*max(20000*x1p+30000*x2p-50000,0) - a*min(1000*x1p+3000*x2p-2500,0) - ...
         a*min(x1p,0) - a*min(x2p,0)
     
     
%      fx= -(3*x1p+2*x2p)+a*max(x1p-4,0)+a*max(x2p-6,0)+...
%          a*max(3*x1p+2*x2p-18,0)+a*max(-x1p,0)+...
%          a*max(-x2p,0);
     
     
     [val,ind]=min(fx); %M?nimo de la funci?n y su posici?n
     
     % Determinar el mejor global
     
     if val<fxpg
         x1pg=x1p(ind,1); %(índice,columna 1)
         x2pg=x2p(ind,1);
         fxpg=val;
     end
     
     %Determinar los mejores locales
     
     for p=1:np  %Para cada particula
         if fx(p,1)<fxpL(p,1) %Compara el desempeño con el mejor local
            fxpL(p,1)=fx(p,1); %Actualiza el desempeño
            x1pL(p,1)=x1p(p,1); %Actualiza posición
            x2pL(p,1)=x2p(p,1);
         end
     end
     
     
     %% NO VA sólo para graficar
     plot(x1p,x2p,'b.',x1pg,x2pg,'go',0,0,'rx');
     %Tercer par?metro es el color y el tipo de l?nea
     axis([0 1 0 1]);
     
     title(['x1pg= ' num2str(x1pg) ' x2pg= ' num2str(x2pg) ' y= ' num2str(fxpg)]);
     pause(0.1);
     
     %% 
     vx1=vx1+c1*rand()*(x1pg-x1p)+c2*rand()*(x1pL-x1p); %Nueva velocidad
     x1p=x1p+vx1; %nueva Posici?n
     
     vx2=vx2+c1*rand()*(x2pg-x2p)+c2*rand()*(x2pL-x2p); %Nueva velocidad
     x2p=x2p+vx2; %nueva Posici?n
 end
fxpg = (0.05^(1/2)*x1p.^2 + 0.05^(1/2)*x2p.^2 )
