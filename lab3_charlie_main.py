import numpy as np

def xi(row_i, x, bi, i, n):
    row = [row_i[0, i] for i in range(n + 1)]
    print(row)
    return (bi - sum([i * j for i, j, index in zip(row, x, range(i))])) / row[i]


def resuelve_ti(mat, b):
    x = [0] * len(mat)
    x[0] = b[0] / mat[0, 0]
    for row, index in zip(mat[1:], range(1, len(x))):
        x[index] = xi(row, x, b[index], index, n)
        print(x[index])
    return x


def resuelve_ts(mat, b):
    n = len(mat)
    x = [0] * n
    x[n - 1] = b[n - 1] / mat[n - 1, n - 1]
    for row, index, bi in zip(mat[::-1, 1:], range(1, n), b[::-1, 1:]):
        x[n - index - 1] = xi(row[::-1], x[::-1], bi, index, n)
    return x


"""
    Funcion que obtiene la foctorizacion LU de una matriz (A = L*U)
    In: A  (la matriz de la que obtenemos la factorizacion)
    Out: L (Matriz triangular inferior)
         U (Matriz triangular superior)
"""


def mi_LU(A):
    n = len(A);
    L = np.matrix(np.identity(n))
    U = A.copy()
    for i in range(0, n - 1):
        # "le asignamos a L la i-esima columna"
        L[i + 1:n, i] = np.divide(U[i + 1:n, i], U[i, i])
        # actualizamos en U la matriz de i+1 * i+1
        U[i + 1:n, i + 1:n] = U[i + 1:n, i + 1:n] - np.divide(U[i + 1:n, i] * U[i, i + 1:n], U[i, i])
        # asiganmos la i-esima columna a U de ceros"
        U[i + 1:n, i] = np.matrix(np.zeros((n - i - 1, 1)))
    return L, U


def resuelve(A, b):
    [L, U] = mi_LU(A)
    y = resuelve_ti(L, b)
    x = resuelve_ts(U, y)
    return x


A = np.matrix([[1, 1, 1, 1], [1, 2, 3, 4], [1, 3, 6, 10], [1, 4, 10, 20]])
b = np.transpose(np.matrix([1, 2, -3, 4]))
print(b)

[L, U] = mi_LU(A)
print(L)
print(U)

x = resuelve(A, b)
print(x)