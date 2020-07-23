from math import *

def tobin(a , digits):
    answer =[0] * digits
    for i in range(digits):
        if (a // 2 ** (digits - i-1) != 0):
            a -= 2** (digits - i-1)
            answer[i] = 1
    answer_str = ""
    for i in range(digits):
        answer_str += str(answer[i])
    return answer_str

print(tobin(45 / 360 * 2 ** 31,32))
print(tobin(135 / 360 * 2 ** 31,32))
print(tobin(225 / 360 * 2 ** 31,32))
print(tobin(315 / 360 * 2 ** 31,32))

print(tobin(120/360 * 2**31 , 32))


for i in range(32):
    a = round(atan(2**(-i)) / (2 * pi) * (2 ** 31))

    string = "assign atan_table[" + str(i) + "] \t= 32'b"+tobin(a,32)+";"
    print(string)

print('\n')
for i in range(1,32):
    a = round(atanh(2**(-i)) * (2 ** 31))

    string = "assign atanh_table[" + str(i) + "] \t= 32'b"+tobin(a,32)+";"
    print(string)
print('\n')
for i in range(32):
    a = round((2**(-i)) * (2 ** 31))

    string = "assign lin_table[" + str(i) + "] \t= 32'b"+tobin(a,32)+";"
    print(string)



number1 = 4293746284;
number2 = -1221012;
k = 0.6073;

print(number1 * 2**(-20) * k)
print(number2 * 2**(-20) * k)

