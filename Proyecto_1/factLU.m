function [L,U] = factLU(A)
%In:
   % matriz A cuadrada
%Out: 
   % L matriz triangular inferior
   % U matriz triangular superior
n = length(A); %para tener la misma dimensión de A
L = eye(n);    %para tener L=matriz identidad
U = A;

for i=1:n-1
    L(i+1:n,i)= (U(i+1:n,i))/(U(i,i));  %Toma la columna i-esima que tiene valores u en A, y los divide 
    U(i+1:n,i+1:n)= U(i+1:n,i+1:n)-((U(i+1:n,i)*U(i,i+1:n))/(U(i,i)));  %Representa la matriz cuadrada que se va achicando con la operación B-uw/a
    U(i+1:n,i) = zeros(n-i,1); %Provoca que la matriz se vaya haciendo triangular superior. Son ceros con dimension n-1 renglones por 1 columna. 
    i=i+1;
end
end

