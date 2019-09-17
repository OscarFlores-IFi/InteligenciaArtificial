clear all;
close all;
clc;

tic;
%% funciÃ³n
% para n variables, se utiliza el formato x(:,i), donde i es la variable
% entre 1 y n. 

% funciÃ³n x1Â²+x2â�´+10 deberÃ¡ escribirse como:
% 'x(:,1).^2 + x(:,2).^4 + 10'

func = '-x(:,1).^2 - x(:,2).^2';

%% ParÃ¡metros
nv = 2; % NÃºmero de variables
iteraciones = 1000;

%Se pueden tomar valores unitarios o como vectores de n dimensiones. 
x_min = [-1000 -5000]; % x min
x_max = [1000 5000]; % x max
tp = [1 2.5]; % tamaÃ±o de paso


elmnts = (x_max-x_min)./tp+1;
nbits = ceil(log2(elmnts));

%% Generar la poblaciÃ³n
np=8; % NÃºmero de pobladores
mp = sum(nbits);% ancho matriz pobladores (suma de bits de cada variable)


xe = zeros(np,nv); % X perteneciente a los enteros positivos (2^n)
for i=1:nv
    xe(:,i) = randi([1,2^nbits(i)],np,1);
end

x = xe.*tp + x_min; % X perteneciente a los reales

fx = eval(func); 


xb = zeros(np,sum(nbits));

for k=1:iteraciones
    fx = eval(func);
    cr = sortrows([fx x],1); % cromosoma
    
    
    
    
    xb(1:nbits(1)) = de2bi(x(:,1));
    if nv>1
        for i=2:nv
            xb(:,nbits(i-1):nbits(i)) = de2bi(xe(:,i));
        end
    end
    %% Selección.
       % X en binarios.
    padresbin1=de2bi(cromosoma(np/2+1:np,2),nbits1);
    padresbin2=de2bi(cromosoma(np/2+1:np,2),nbits2);
    %Selecciï¿½n de mejores y conversiï¿½n

    %% Cruzamiento aritmï¿½tico
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

       %% Mutaciï¿½n
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
y=-(20 + x1real.^2 + x2real.^2 - 10*cos(2*pi*x1real) - 10*cos(2*pi*x2real));
cromosoma=[y x1 x1real x2 x2real];

[val,ind]=max(y);

disp(['x1= ' num2str(cromosoma(ind,3)) 'x1= ' num2str(cromosoma(ind,5)) ' y= ' num2str(-val)])

toc;



