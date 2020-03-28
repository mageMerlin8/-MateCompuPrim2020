clear
close all
clc

% se tiene que crear una matriz de adherencia de 32 por 32 que represente
% las colindancias entre los estados. 
%Por logica, sera una matriz simetrica, con la diagonal de 0 pues un estado
%no colinda con si mismo
%como es una matriz sim�trica, basta con hacer la parte triangular superior
%y sumarle su transpuesta para obtener la matriz completa. 

col = zeros(32,32);
col(1,14) = 1;
col(1,32)=1; 
col(2,3)=1;
col(2,26)=1;
col(4,23)=1;
col(4,27)=1;
col(4,31)=1;
col(5,8)=1;
col(5,10)=1;
col(5,19)=1;
col(5,24)=1;
col(5,32)=1;
col(6,14)=1;
col(6,16)=1;
col(7,20)=1;
col(7,27)=1;
col(7,30)=1;
col(8,10)=1;
col(8,25)=1;
col(8,26)=1;
col(9,15)=1;
col(9,17)=1;
col(10,18)=1;
col(10,25)=1;
col(10,32)=1;
col(11,14)=1;
col(11,16)=1;
col(11,22)=1;
col(11,24)=1;
col(11,32)=1;
col(12,15)=1;
col(12,16)=1;
col(12,17)=1;
col(12,20)=1;
col(12,21)=1;
col(13,15)=1;
col(13,21)=1;
col(13,22)=1;
col(13,24)=1;
col(13,29)=1;
col(13,30)=1;
col(14,16)=1;
col(14,18)=1;
col(14,24)=1;
col(15,16)=1;
col(15,17)=1;
col(15,21)=1;
col(15,22)=1;
col(15,29)=1;
col(16,22)=1;
col(16,22)=1;
col(17,21)=1;
col(18,25)=1;
col(18,32)=1;
col(19,24)=1;
col(19,28)=1;
col(19,32)=1;
col(20,21)=1;
col(20,30)=1;
col(21,29)=1;
col(21,30)=1;
col(22,24)=1;
col(23,31)=1;
col(24,28)=1;
col(24,30)=1;
col(24,32)=1;
col(25,26)=1;
col(27,30)=1;
col(28,30)=1;

%A continuación se va a hacer la suma de la triangular superior y su
%transpuesta
colindancias = col+ transpose(col);


%Para contar cuantos estados colindan con un estado, vamos a hacer un
%vector de 32 en donde se introducirán la cantidad de estados colindantes

numcol = (sum(colindancias,2));

%Para el vector de población vamos a traer la información de un archivo de
%Excel
poblacion = readtable('DatosExcel.xlsx','Range','D6:D38');
poblacion = table2array(poblacion);   %Para convertir una tabla en arreglo


%En el caso 1 el conjunto I es: I1 = {CDMX,Morelos, Chiapas,Nuevo Leon }
%En términos de M eso corresponde a {M9,M17,M7,M19}
I = [9, 17, 7, 19];

% creamos el vector que tiene las probabilidades de los afectados
p = zeros(length(colindancias),1);
p (I(1)) = .00315;
p (I(2)) = .000615;
p (I(3)) = .000369;
p (I(4)) = .000891;


%antes de todo creamos la matriz base A, que tiene -1 si dos
%estados son colindantes y la cantidad de vecinos más uno en la diagonal
%indicando la cantidad de vecinos +1 de cada estado

A=colindancias*-1;  
for i = 1:length(A)
    A(i,i) = numcol(i) + 1;
end

%de esta matriz le tenemos que quitar las columnas y renglones de los
%estados afectados

%notemos que para quitar el estado i, habiendo quitado j estados antes, tenemos que
%usar A(i-j,:) = []; A(:,i-j)=[];
% en este caso el estado i tiene índice I(i) y se han quitado (i-1) al
% momento de quitar el I(i)

Is = sort(I);
for i = 1:length(I)
    A(Is(i) - (i-1),     :       ) = []; 
    A(      :     , Is(i) - (i-1)) = []; 
end

%El vector b (para resolver el sistema Ax=b) tiene en b(i) la suma de los
%porcentajes de la población que tuvo la enfermedad en el periodo inicial 
%en cada uno de los estados vecinos. 

b = colindancias*p; 
%tenemos que quitar el valor de los estados donde inicio el virus
for i = 1:length(I)
    b(Is(i) - (i-1)) = []; 
end

%Resolvemos el sistema Aw=b 
% en apéndice 2 del reporte demostramos que A es una matriz
% simétrica positiva definida, por lo que podemos usar la factorización de Cholesky

w = ResuelveCholesky(A, b);

%Para poder tener en un vector el índice epidemiológico de los 32 estados,
%crearemos un vector de 32 renglones donde insertaremos los respectivos
%índices

indices = zeros(length(colindancias),1);

% el manejo "extraño" de índices es para saltarse a las posiciones de estados infectados
% del vector w y asignarles su porcentaje de población infectada
j = 1;
for i = 1: (length(colindancias) - length(I))
    % este while nos sirve para saltarnos los índices de los estados infectados
    while( j <= length(I) && i+(j-1) == Is(j))
        j = j+1;
    end
    indices(i + (j-1), 1) = w(i); 
end

%aquí asignamos los índices de los estados infectados
for i = 1: length(I)
    indices(I(i)) = p(I(i));
end

%Ahora lo único que falta es realizar la operación del indice epidemiológico
%por la población de cada estado. Para ello crearemos un vector de 32 en
%donde cada elemento de la matriz sea dicha multiplicación

probabilidad = poblacion.*indices;

x = linspace(1, length(colindancias), length(colindancias));

figure
plot(x, indices, '.k', 'MarkerSize', 10)
title('Índice epidemiológico por estado')


figure
plot(x, probabilidad, '.r', 'MarkerSize', 10)
title('Probabilidad de contagio por estado')


%En el caso 2 el conjunto I es: I2 = {Yucatan,Tamaulipas, Guanajuato,Zacatecas}
%En términos de M eso corresponde a {M31,M28,M11,M32}
%Procedemos de la misma forma que en el caso 1
%A partir de aquí no comentamos el proceso porque los comentarios serían los mismos
%que los del caso 1

I = [31, 28, 11, 32];
p = zeros(length(colindancias),1);
p (I(1)) = .00315;
p (I(2)) = .000615;
p (I(3)) = .000369;
p (I(4)) = .000891;

A=colindancias*-1;  
for i = 1:length(A)
    A(i,i) = numcol(i) + 1;
end
b = colindancias*p; 
%eliminamos las cosas de A y b que tienen que ver con los infectados
%iniciales

Is = sort(I);
for i = 1:length(I)
    A(Is(i) - (i-1),     :       ) = []; 
    A(      :     , Is(i) - (i-1)) = []; 
    b(Is(i) - (i-1)) = []; 
end

w = ResuelveCholesky(A, b);

indices = zeros(length(colindancias),1);
j = 1;
for i = 1: (length(colindancias) - length(I))
    while( j < length(I)+1 && i+(j-1) == Is(j))
        j = j+1;
    end
    indices(i + (j-1), 1) = w(i); 
end

for i = 1: length(I)
    indices(I(i)) = p(I(i));
end


probabilidad = poblacion.*indices;
x = linspace(1, length(colindancias), length(colindancias));

figure
plot(x, indices, '.k', 'MarkerSize', 10)
title('Índice epidemiológico por estado')


figure
plot(x, probabilidad, '.r', 'MarkerSize', 10)
title('Probabilidad de contagio por estado')


%En el caso 3 el conjunto I es: I3 = {Ciudad de México, Sonora, Veracruz, Oaxaca}
%En términos de M eso corresponde a {M9,M26,M30,M20}
%Procedemos de la misma forma que en los casos anteriores
p = zeros(length(colindancias),1);

I = [9,26,30,20];
for i = 1: length(I)
    p(I(i)) = i^2 * 0.000000001; 
end

p (I(1)) = p(I(1))* 181866;
p (I(2)) = p(I(2))* 176115;
p (I(3)) = p(I(3))* 180873;
p (I(4)) = p(I(4))* 181143;

A=colindancias*-1;  
for i = 1:length(A)
    A(i,i) = numcol(i) + 1;
end
b = colindancias*p; 
%eliminamos las cosas de A y b que tienen que ver con los infectados
%iniciales

Is = sort(I);
for i = 1:length(I)
    A(Is(i) - (i-1),     :       ) = []; 
    A(      :     , Is(i) - (i-1)) = []; 
    b(Is(i) - (i-1)) = []; 
end

w = ResuelveCholesky(A, b);

indices = zeros(length(colindancias),1);
j = 1;
for i = 1: (length(colindancias) - length(I))
    while( j < length(I)+1 && i+(j-1) == Is(j))
        j = j+1;
    end
    indices(i + (j-1), 1) = w(i); 
end

for i = 1: length(I)
    indices(I(i)) = p(I(i));
end


probabilidad = poblacion.*indices;
x = linspace(1, length(colindancias), length(colindancias));

figure
plot(x, indices, '.k', 'MarkerSize', 10)
title('Índice epidemiológico por estado')


figure
plot(x, probabilidad, '.r', 'MarkerSize', 10)
title('Probabilidad de contagio por estado')
















