# se importan las funciones que se van a usar
from math import exp
import numpy as np


# transformación definida en el lab
def transforma_vector(x):
    x_max = max(x)
    return [i - x_max for i in x]


# primer intento de softmax
def mi_softmax(x):
    suma = sum([exp(i) for i in x])
    return [exp(i) / suma for i in x]


# segundo intento de softmax
def mi_softmax_2(x):
    x_t = transforma_vector(x)
    return mi_softmax(x_t)


def numpy_sofmax(x):
    return np.exp(x) / np.sum(np.exp(x), axis=0)


def numpy_sofmax_t(x):
    x_t = transforma_vector(x)
    return np.exp(x_t) / np.sum(np.exp(x_t), axis=0)
