import cv2
import numpy as np

stack = []
mat = np.zeros((500,500))
x_max, y_max = mat.shape[0], mat.shape[1]

a , b, count = -2, 400, 0
for x in range(0,140,2):
    y = a * x + b
    mat[x,y] = 1
    stack.append([x,y])
    count+=1

#Generate 30% data
for x in range(0,(count*3)//7):
    x, y = np.random.random_integers(low=0, high=x_max-2, size=None), np.random.random_integers(low=0, high=y_max-2, size=None)
    mat[int(x),int(y)]=1
    stack.append([x,y])
cv2.imshow('original', mat)

#Random 2 points A and B, Calculate line function with a, b
for x in range (0, y_max):
    index1 = np.random.random_integers(low=0, high=len(stack), size=None)
    index2 = np.random.random_integers(low=0, high=len(stack), size=None)
    print('index 1 and 2: ', index1, index2)
    if(stack[index1][0] != stack[index2][0]):
        a = (stack[index1][1] - stack[index2][1])//(stack[index1][0] - stack[index2][0])
        b = (stack[index1][1] - a*stack[index1][0])
        print('check:', a, b)
    else:
        continue
    count = 0
    # Count point in line function 
    for s in stack:
        if s[0]*a + b == s[1]:
            count+=1
    # If count > 0.7*n then draw a line in the function and stop
    if count >= 0.7 * len(stack):
        print('Thoa dieu kien', a, b)
        cv2.line(mat, (a*0 + b, 0), (a * x_max + b, x_max),(255, 0, 0),2)
        break

cv2.imshow('result', mat)
cv2.waitKey(0)