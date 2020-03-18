function [x] = TrSupe(b,U)
%Insertas una matriz x de dimensión de b
n = length(b);
x=zeros(n,1);
x(n)=b(n)/U(n,n);

for i=(n-1):-1:1
    sumat = 0;
    for j=1:n %la cuenta de este for tiene que ir de derecha a izquierda, porque la matriz es triangular superior
        s=U(i,j)*x(j);
        sumat=sumat+s;
        j=j+1;
    end
    x(i)=(b(i)-sumat)/(U(i,i));
    i=i+1;
    
end
end

