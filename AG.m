clear all;
close all;
clc;

tic;
%% Par�metros
x1min=-3; %l�mite inferior
x1max=3; %l�mite superior
tp1=0.01; %tama�o de paso

x2min=-3; %l�mite inferior
x2max=3; %l�mite superior
tp2=0.01; %tama�o de paso

elementos1=(x1max-x1min+1)/tp1; %Cantidad de n�meros
nbits1=ceil(log2(elementos1)); %N�mero de bits

elementos2=(x2max-x2min+1)/tp2; %Cantidad de n�meros
nbits2=ceil(log2(elementos2)); %N�mero de bits


%% Generar la poblaci�n
np=32; %N�mero de pobladores

x1=randi([0 2^nbits1-1],np,1); %padres enteros positivos
x2=randi([0 2^nbits2-1],np,1); %padres enteros positivos

x1real=(x1max-x1min)*x1/(2^nbits1-1)+x1min; 
x2real=(x2max-x2min)*x1/(2^nbits2-1)+x2min; 

%Conversi�n de entero a Real
for k=1:5000
%     y=-(x1real+10.125).^2+50; %Evaluaci�n
    y=-(20 + x1real.^2 + x2real.^2 - 10*cos(2*pi*x1real) - 10*cos(2*pi*x2real))
    yprom(k)=mean(y);
    cromosoma=sortrows([y x1 x1real x2 x2real],1);
    % cromosoma=[x1 x1real y];
    % cromosoma=sortrows(cromosoma,size(cromosoma,2))

    %% Selecci�n
    padresbin1=de2bi(cromosoma(np/2+1:np,2),nbits1);
    padresbin2=de2bi(cromosoma(np/2+1:np,2),nbits2);
    %Selecci�n de mejores y conversi�n

    %% Cruzamiento aritm�tico
    for i=1:np/2
        j=i+1;
        if j==np/2+1
            j=1;
        end
        hijo1(i,1)=cromosoma(np/2+i,2)+cromosoma(np/2+j,2);
        hijobin1(i,:)=de2bi(hijo1(i,1),nbits1+1);
        hijo2(i,1)=cromosoma(np/2+i,4)+cromosoma(np/2+j,4);
        hijobin2(i,:)=de2bi(hijo2(i,1),nbits2+1)
    end
        hijobin1=hijobin1(:,1:end-1);
        hijobin2=hijobin2(:,1:end-1);

       %% Mutaci�n
       m=rand();
       if m>=.8
           nhijo=randi(np/2);
           bit=randi(nbits1);
           if hijobin1(nhijo,bit)==1
               hijobin1(nhijo,bit)=0;
           else
               hijobin1(nhijo,bit)=1;
           end
           
           nhijo=randi(np/2);
           bit=randi(nbits2);
           if hijobin2(nhijo,bit)==1
               hijobin2(nhijo,bit)=0;
           else
               hijobin2(nhijo,bit)=1;
           end
       end
       hijoent1=bi2de(hijobin1); %se pasa de decimal a entero
       hijoreal1=(x1max-x1min)*hijoent1/(2^nbits1-1)+x1min;
       hijoent2=bi2de(hijobin2); %se pasa de decimal a entero
       hijoreal2=(x2max-x2min)*hijoent2/(2^nbits2-1)+x2min;
       %hijos enteros a reales
       x1=[cromosoma(np/2+1:np,2); hijoent1];
       x1real=[cromosoma(np/2+1:np,3); hijoreal1];
       x2=[cromosoma(np/2+1:np,2); hijoent2];
       x2real=[cromosoma(np/2+1:np,3); hijoreal2];
       clear hijobin1
       clear hijobin2

end   
   
plot(yprom)
y=-(20 + x1real.^2 + x2real.^2 - 10*cos(2*pi*x1real) - 10*cos(2*pi*x2real))
cromosoma=[y x1 x1real x2 x2real];

[val,ind]=max(y);

disp(['x1= ' num2str(cromosoma(ind,3)) 'x1= ' num2str(cromosoma(ind,5)) ' y= ' num2str(-val)])

toc;
