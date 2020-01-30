def xi(row_i, x, bi, i):
    return (bi - sum([i * j for i, j, index in zip(row_i, x, range(i))])) / row_i[i]


def resuelve_ti(mat, b):
    x = [0] * len(mat)
    x[0] = b[0] / mat[0][0]
    for row, index in zip(mat[1:], range(1, len(x))):
        x[index] = xi(row, x, b[index], index)
    return x


def resuelve_ts(mat, b):
    n = len(mat)
    x = [0] * n
    x[n - 1] = b[n - 1] / mat[n - 1][n - 1]
    for row, index, bi in zip(mat[::-1][1:], range(1, n), b[::-1][1:]):
        x[n - index - 1] = xi(row[::-1], x[::-1], bi, index)
    return x
