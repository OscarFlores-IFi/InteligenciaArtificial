% Disculpa por todas las faltas de ortografia, Matlab no permite acentos. 

clear all;
close all;
clc;

tic;
%% funcion
% para n variables, se utiliza el formato x(:,i), donde i es la variable
% entre 1 y n. Algoritmo genetico busca maximizar. 

% funcion x1^2+x2^2+10 debera¡ escribirse como:
% 'x(:,1).^2 + x(:,2).^4 + 10'

func = '-x(:,1).^2 - x(:,2).^2';

%% Parametros
nv = 2; % Numero de variables
iteraciones = 10000;

%Se pueden tomar valores unitarios o como vectores de n dimensiones. 
x_min = [-10000 -50000]; % x min
x_max = [10000 50000]; % x max
tp = [1 2]; % tamanio de paso


elmnts = (x_max-x_min)./tp+1;
nbits = ceil(log2(elmnts));

%% Generar la poblacion
np=256; % Numero de pobladores
mp = sum(nbits);% ancho matriz pobladores (suma de bits de cada variable)


xe = zeros(3/2*np,nv); % X perteneciente a los enteros positivos (2^n)
for i=1:nv
    xe(:,i) = randi([1,2^nbits(i)-1],3/2*np,1);
end

x = xe.*tp + x_min; % X perteneciente a los reales

acum = cumsum([1 nbits]); % acumulados en binarios
xb = zeros(3/2*np,sum(nbits)); % x en binarios
hb = zeros(np,sum(nbits)); % hijos binarios
he = zeros(np,nv); % hijos enteros
selh = zeros(np,sum(nbits));

hist = zeros(iteraciones,1);









%% Algoritmo Genetico

for k=1:iteraciones
    fx = eval(func); % evaluamos la funcion
    
    for i=1:nv
       xb(:,acum(i):acum(i+1)-1) = de2bi(xe(:,i)); % convertimos a binarios
    end
    
    %% Seleccion.
    
    [out, idx] = sort(fx);    
%     pb = xb(idx,:); % todos los padres en binario  
    p = x(idx(np+1:end),:);
    pe = xe(idx(np+1:end),:);
    pb = xb(idx(np+1:end),:); % la mitad de los padres (los mejores)
   
    hist(k) = mean(out(np:end));
    %% Cruzamiento por mascara
    
    sel = randi([1,np/2],np,sum(nbits)); % Mascaras
    for i=1:sum(nbits)
        hb(:,i) = pb(sel(:,i),i); % hijos binarios cruzados
    end

    %% Mutacion
    
    pct = .075; % muta el pct porciento de los digitos de los hijos
    mut = rand(np,sum(nbits)); % Crea matriz de mutacion
    hb(mut<pct) = abs(hb(mut<pct)-1); % hijos binarios mutados
    
    for i=1:nv
        he(:,i) = bi2de(hb(:,acum(i):acum(i+1)-1)); % hijos a enteros
    end
    h = he.*tp + x_min; % hijos

    x = [h;p]; % Vector x a evaluar.
    xe = (x - x_min)./tp;
end   

disp(fx)   
plot(hist)
toc;
