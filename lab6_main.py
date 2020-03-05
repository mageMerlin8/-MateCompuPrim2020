import matplotlib.pyplot as plt
import numpy as np
import functools

#
# x = np.linspace(1, 10, 20)
# y = [i for i in range(1, 21)]
#
# plt.plot(x, y, 'r*')
# plt.show()

#########
puntos_6 = [
    (0, 0),
    ((np.pi / 2), 1),
    (np.pi, 0),
    (3 * np.pi/2, -1),
    (2 * np.pi, 0)
]


# p es una lista de tuplas de dos elementos (xi, yi)
def matriz_newton(p):
    n = len(p)
    mat = np.zeros((n, n))

    # unos primera col
    for i in range(n):
        mat[i][0] = 1

    # los otros elementos
    for i in range(1, n):
        for j in range(i, n):
            # consigue todos los elementos de columnas pasadas
            tot_pasado = np.prod([mat[j][col] for col in range(1, i)])
            nuevo = p[j][0] - p[i-1][0]
            print(nuevo * tot_pasado)
            mat[j][i] = nuevo * tot_pasado

            pass
    print(mat)
    pass


matriz_newton(puntos_6)
