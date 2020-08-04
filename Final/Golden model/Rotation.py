import math
import TestGenerator

circular = 1
linear = 0
hyperbolic = -1


def ROM_lookup(iteration, coordinate):
    if coordinate == circular:
        return math.atan(2 ** (-1 * iteration))
    elif coordinate == linear:
        return 2 ** (-1 * iteration)
    elif coordinate == hyperbolic:
        return math.atanh(2 ** (-1 * iteration))


def preProcessOnValues(x, y, z):
    z = z % 360
    if z > 180:
        z = 360 - z
    if z > 90:
        next_x = -y
        next_y = x
        x = next_x
        y = next_y
        z = z - 90
    elif z < -90:
        next_x = y
        next_y = -x
        x = next_x
        y = next_y
        z = z + 90
    z = math.radians(z)
    return x, y, z


def multiplyKValues(x, y, coordinate):
    circular_k = 0.607252935
    linear_k = 1
    hyperbolic_k = 1.2075

    if coordinate == circular:
        x = x * circular_k
        y = y * circular_k
    elif coordinate == linear:
        x = x * linear_k
        y = y * linear_k
    elif coordinate == hyperbolic:
        x = x * hyperbolic_k
        y = y * hyperbolic_k
    return x, y


def rotation_mode(x, y, z, coordinate, iterations):
    x, y, z = preProcessOnValues(x, y, z)

    if coordinate == hyperbolic:
        i = 1
    else:
        i = 0

    flag = 0

    while i < iterations:
        if z < 0:
            di = -1
        else:
            di = +1

        next_x = x - coordinate * di * y * (2 ** (-1 * i))
        next_y = y + di * x * 2 ** (-1 * i)
        next_z = z - di * ROM_lookup(i, coordinate)

        x = next_x
        y = next_y
        z = next_z

        if coordinate == hyperbolic:
            if (i != 4) & (i != 13) & (i != 40):
                i = i + 1
            elif flag == 0:
                flag = 1
            elif flag == 1:
                flag = 0
                i = i + 1
        else:
            i = i + 1

    x, y = multiplyKValues(x, y, coordinate)
    return x, y, math.degrees(z)


rot_x = 2
rot_y = 1
rot_z = 270
crd_sys = linear
max_iter = 15
x, y, z = rotation_mode(rot_x, rot_y, rot_z, crd_sys, max_iter)
TestGenerator.writeToFileRotation(rot_x, rot_y, rot_z, x, y, z)