# resuelve matrices cuadradas triangulares
from lab2.resuelve_triangulares import resuelve_ts, resuelve_ti

m1 = [[1, 0, 0],
      [1, 1, 0],
      [1, 1, 1]]

m2 = [[1, 1, 1],
      [0, 1, 1],
      [0, 0, 1]]
b1 = [1, 3, 6]
b2 = [6, 3, 1]

print(resuelve_ti(m1, b1))
print(resuelve_ts(m2, b2))
