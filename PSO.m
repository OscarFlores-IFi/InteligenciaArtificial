clear all;
close all;
clc;

%% Formato para ingresar funciones
% para n variables, se utiliza el formato x(:,i), donde i es la variable
% entre 1 y n. 

% función x1²+x2?+10 deberá escribirse como:
% 'x(:,1).^2 + x(:,2).^4 + 10'
     
rest1 = '20000*x(:,1)+30000*x(:,2)-50000';
rest2 = '1000*x(:,1)+3000*x(:,2)-2500';

func = '(0.05^(1/2).*x(:,1).^2 + 0.05^(1/2).*x(:,2).^2 +  0.10*x(:,1).*x(:,2)) + a*max(eval(rest1),0) - a*min(eval(rest2),0) - a*min(x(:,1),0) - a*min(x(:,2),0)';
%% Parametros iniciales
nv = 2; %Numero de variables
np=1000; %Numero de particulas


func_min = [0 0]; %Valor mínimo cerca del cual se espera que converga la función
func_max = [1 1]; %Valor máximo cerca del cual se espera que converja la función
% func_min/max puede ingresarse como un vector de longitud nv en donde se
% especifica el min y max de cada variable en su respectiva posicion o se
% puede ingresar como un escalar general para todas las variables. 


c1 = 0.01; % Velocidad de convergencia a mínimo global
c2 = 0.01; % Velocidad de convergencia a mínimo local
a=10000; %Penalización


iteraciones = 5000; 
Graficar = true
%Graficar = false

%% PSO
x = rand(np,nv).*(func_max-func_min)+func_min; % Posición de inicio de x
xl = x; % Mejor local es x en la primer iteración. 
vx = zeros(np,nv); % velocidad de x inicializada en 0

fx = eval(func); %se evalúa la función
fxl = fx; %los mejores locales en la primera iteración son los mismos que la primer evaluación
[fxg,ind] = min(fx);
xg = x(ind,:);


for k=1:iteraciones
    %Mínimo de la función y su posición
    fx = eval(func);
    [val,ind]=min(fx); 

    % Determinar el mejor global
    if val<fxg
        xg = x(ind,:);
        fxg = val;
    end
    disp('mejor x')
    disp(xg)
    disp(['f(x) = ' num2str(fxg)])
    
    %Determinar los mejores locales
    fxl(fxl<fx) = fx(fxl<fx);
    xl(fxl<fx) = x(fxl<fx);

    % Graficar
	if Graficar && nv==2
        plot(xg(1), xg(2), 'go', x(:,1), x(:,2), 'b.')
        axis([func_min(1) func_max(1) func_min(2) func_max(2)])
        title(['x1=' num2str(xg(1)) ' x2=' num2str(xg(2)) ' y=' num2str(fxg)])
        xlabel('x1')
        ylabel('x2')
        pause(0.1)
    end
    
    % Velocidad de las partículas
    vx = vx+c1*rand()*(xg-x)+c2*rand()*(xl-x);
    x = x + vx;
end
