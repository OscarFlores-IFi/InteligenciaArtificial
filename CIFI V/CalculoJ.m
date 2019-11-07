function [J, i] = CalculoJ(data, red)
%% Calculo de J 
% data = data por clasificar. 
% red = competlayer entrenada. 
mat = red.IW{:};
Y = vec2ind(red(data));
grupos = unique(Y);


J = 0 ;
for i = 1:size(grupos,2)
    temp = data(:,Y==grupos(i))';
    res = temp - mat(grupos(i),:);
    g = 0;
    for j=1:size(temp,1)
        g = g + norm(res(j,:));
    end
    J = J + g/j;
end
J = J/i;
end
