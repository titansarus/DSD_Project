from math import *


def tobin(a, digits):
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
    print(x * 2 ** (-20))


def angleConverter(angle):
    print(angle * 2 ** (-31) * 360)

def degToBinary(angle):
    print(tobin(angle /360 * 2**31 ,32))
def xyToBinary(x):
    print(tobin(x* 2**20,32))


k = 0.6073

print(tobin(45 / 360 * 2 ** 31, 32))
print(tobin(135 / 360 * 2 ** 31, 32))
print(tobin(225 / 360 * 2 ** 31, 32))
print(tobin(315 / 360 * 2 ** 31, 32))

for i in range(32):
    a = round(atan(2 ** (-i)) / (2 * pi) * (2 ** 31))

    string = "assign atan_table[" + str(i) + "] \t= 32'b" + tobin(a, 32) + ";"
    print(string)

print('\n')
for i in range(1, 32):
    a = round(atanh(2 ** (-i)) * (2 ** 31))

    string = "assign atanh_table[" + str(i) + "] \t= 32'b" + tobin(a, 32) + ";"
    print(string)
print('\n')
for i in range(32):
    a = round((2 ** (-i)) * (2 ** 31))

    string = "assign lin_table[" + str(i) + "] \t= 32'b" + tobin(a, 32) + ";"
    print(string)
