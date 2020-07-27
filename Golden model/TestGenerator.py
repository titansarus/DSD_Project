from math import *


def toBin(a, digits):
    answer = [0] * digits
    for i in range(digits):
        if (a // 2 ** (digits - i - 1) != 0):
            a -= 2 ** (digits - i - 1)
            answer[i] = 1
    answer_str = ""
    for i in range(digits):
        answer_str += str(answer[i])
    return answer_str


def xyConverter(x):
    return x * 2 ** (-20)


def angleConverter(angle):
    return angle * 2 ** (-31) * 360


def degToBinary(angle):
    return toBin(angle / 360 * 2 ** 31, 32)


def xyToBinary(x):
    return toBin(x * 2 ** 20, 32)


def writeToFileRotation(input_x, input_y, input_z, output_x, output_y, output_z):
    f = open("RotationLinear.txt", "a")
    input_x = xyToBinary(input_x)
    input_y = xyToBinary(input_y)
    input_z = degToBinary(input_z)
    output_x = xyToBinary(output_x)
    output_y = xyToBinary(output_y)
    output_z = degToBinary(output_z)
    f.write(input_x + " " + input_y + " " + input_z + " " + output_x + " " + output_y + " " + output_z + "\n")


def writeToFileVectoring(input_x, input_y, output_x, output_y, output_z):
    f = open("VectoringCircular.txt", "a")
    input_x = xyToBinary(input_x)
    input_y = xyToBinary(input_y)
    output_x = xyToBinary(output_x)
    output_y = xyToBinary(output_y)
    output_z = degToBinary(output_z)
    f.write(input_x + " " + input_y + " " + output_x + " " + output_y + " " + output_z + "\n")


def printArcTanTable():
    print(toBin(45 / 360 * 2 ** 31, 32))
    print(toBin(135 / 360 * 2 ** 31, 32))
    print(toBin(225 / 360 * 2 ** 31, 32))
    print(toBin(315 / 360 * 2 ** 31, 32))

    for i in range(32):
        a = round(atan(2 ** (-i)) / (2 * pi) * (2 ** 31))

        string = "assign atan_table[" + str(i) + "] \t= 32'b" + toBin(a, 32) + ";"
        print(string)

    print('\n')
    for i in range(1, 32):
        a = round(atanh(2 ** (-i)) * (2 ** 31))

        string = "assign atanh_table[" + str(i) + "] \t= 32'b" + toBin(a, 32) + ";"
        print(string)
    print('\n')
    for i in range(32):
        a = round((2 ** (-i)) * (2 ** 31))

        string = "assign lin_table[" + str(i) + "] \t= 32'b" + toBin(a, 32) + ";"
        print(string)
