function [x] = TrInf(b,L)
%% Insertas una matriz x de la dimension de b y l
n = length(b);
x = zeros(n,1);
for i=1:n
    sumat = 0;
    for j=1:i-1
        s = L(i,j)*(x(j));
        sumat = sumat+s;
        j=j+1;
    end
    x(i) = (b(i)-sumat)/L(i,i);
    i=i+1;
end
end

