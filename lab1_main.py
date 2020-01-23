from lab1.softmax import *

# se declaran los vectores
x1 = [1, 2, 3, 4, 5]
x2 = [i * 1000 for i in x1]
x3 = [1, 2, 3, 4, 5000]

# ------------  PRUEBAS  ----------#
|
# prueba softmax 1 esta 
# prueba truena, comentala para que corran las demás
# print('--------Sofmax 1----------')
# for v in [x1, x2, x3]:
#     print('Original: ', v)
#     print('Softmax: ', mi_softmax(v))

# prueba softmax 2
# softmax 2 
print('--------Sofmax 2----------')
for v in [x1, x2, x3]:
    print('Original: ', v)
    print('Softmax: ', mi_softmax_2(v))

# prueba softmax 3
print('--------Sofmax Numpy----------')
for v in [x1, x2, x3]:
    print('Original: ', v)
    print('Softmax: ', numpy_sofmax(v))

# prueba softmax 3
print('--------Sofmax Numpy 2 (transformado)----------')
for v in [x1, x2, x3]:
    print('Original: ', v)
    print('Softmax: ', numpy_sofmax(v))
