%% PSO (busca minimizar J.)
clear all;
close all;
clc;
% Se optimizará una cubeta, esta deberá tener un volumen de 20cm3, una base
% de radio 'r', una tapa de radio 'r+1.5' y una altura 'h'. Minimizar
% costos suponiendo que cuerpo y base cuestan $1/cm2 y tapa $2/cm2

%% Formato para ingresar funciones
% para n variables, se utiliza el formato x(:,i), donde i es la variable
% entre 1 y n. 

% función x1²+x2⁴+10 deberá escribirse como:
% func = 'x(:,1).^2 + x(:,2).^4 + 10'

vol = 'pi/3.*x(:,2).*((x(:,1) + 1.5).^2 + x(:,1).^2 + (x(:,1) + 1.5).*x(:,1))' % Volumen 
p1 = 'max(20 - eval(vol),0)' % Si volumen < 20
p2 = 'max(eval(vol) - 20,0)' % Si volumen > 20 

lateral = 'pi * (2*x(:,1) + 1.5) .* (x(:,2).^2 + 1.5^2).^(0.5)'
tapa = 'pi * (x(:,1) + 1.5).^2'
base = 'pi * x(:,1).^2'

func = '2 * eval(tapa) + eval(base) + eval(lateral) + a*eval(p1) + a*eval(p2) - a*min(x(:,1),0) - a*min(x(:,2),0)'

% (otras funciones de ejemplo)
% altura = 8.5
% base = 11
% func = '-(x(:,1).*sin(x(:,2)).*(altura-2*(x(:,1)).*sin(x(:,2))).*((base-2*x(:,1))+x(:,1).*cos(x(:,2)))) + a*max(x(:,2)-pi/2,0) + a*max(x(:,1)-base/2,0) + a*max(x(:,1).*sin(x(:,2))-altura/2,0) - min(x(:,1),0) - min(x(:,2),0)'
% func= '(0.05^(1/2)*x(:,1).^2 + 0.05^(1/2)*x(:,2).^2 ) + a*max(20000*x(:,1)+30000*x(:,2)-50000,0) - a*min(1000*x(:,1)+3000*x(:,2)-2500,0) - a*min(x(:,1),0) - a*min(x(:,2),0)'


%% Parametros iniciales
nv = 2; %Numero de variables
np=10000; %Numero de particulas


func_min = [0 0]; %Valor mínimo cerca del cual se espera que converga la función
func_max = [5 5]; %Valor máximo cerca del cual se espera que converga la función
% func_min/max puede ingresarse como un vector de longitud nv en donde se
% especifica el min y max de cada variable en su respectiva posicion o se
% puede ingresar como un escalar general para todas las variables. 


c1 = 0.1; % Velocidad de convergencia a mínimo global
c2 = 0.1; % Velocidad de convergencia a mínimo local
a=1000000; %Penalización


iteraciones = 1000; 
Graficar = true
% Graficar = false

%% PSO
x = rand(np,nv).*(func_max-func_min)+func_min; % Posición de inicio de x
xl = x; % Mejor local es x en la primer iteración. 
vx = zeros(np,nv); % velocidad de x inicializada en 0

fx = eval(func); %se evalúa la función
fxl = fx; %los mejores locales en la primera iteración son los mismos que la primer evaluación
[fxg,ind] = min(fx);
xg = x(ind,:);


for k=1:iteraciones
    disp(['iteracion: ' num2str(k)])
    
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
    fxl(fxl<fx)=fx(fxl<fx);

    % Graficar
	if Graficar && nv==2
        plot(xg(1), xg(2), 'go', x(:,1), x(:,2), 'b.')
%         axis([-5 5 -5 5]);
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

% Mejor x: [0.9894 1.9813] si tapa cuesta lo mismo que base y sup. lateral
% Mejor x: [1.1846 1.6298] si tapa cuesta el doble que base y sup. lateral




