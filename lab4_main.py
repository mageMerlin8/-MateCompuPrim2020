import numpy as np
from scipy.linalg import lu, lu_factor, lu_solve, cholesky
from math import sqrt

'''
---
[
[16, -12, -12, -16],
[-12, 25, 1, -4],
[-12, 1, 17, 14],
[-16, -4, 14, 57],
]

---
'''

A = [
    [16, -12, -12, -16],
    [-12, 25, 1, -4],
    [-12, 1, 17, 14],
    [-16, -4, 14, 57],
]


def diag(A):
    print(A[2][2])
    return [A[i][i] for i in range(len(A))][0]


def diag_vector(v):
    A = [0] * len(v)
    for i in range(len(v)):
        row_i = [0] * len(v)
        row_i[i] = v[i]
        A[i] = row_i
    return A


def mi_cholesky(A):
    print(np.array(A))
    l, u, p = lu(np.array(A), False)
    # c = cholesky(np.array(A))
    # c1 = cholesky(np.array(A),True)
    # LU, pvt = lu_factor(A)
    print(l)
    print(u)
    print(p)
    # print(c)
    # print(c1)
    # print(np.multiply(c,c.T.conj()))
    # print(diag(   LU))
    # d = [sqrt(i) for i in diag(LU)]
    # print(d)
    # D = diag_vector(d)
    # print(D)
    # return np.multiply(L, D)

