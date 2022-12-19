import cv2
import numpy as np

bao = cv2.imread('D:/DATASCIENTIST/CS231/Buoi11/bao.jpg')
sutu = cv2.imread('D:/DATASCIENTIST/CS231/Buoi11/sutu.jpg')
sutu = cv2.resize(sutu, (474,296))


T = bao.copy()
for f in range (72):
    t = float(f)/72
    for i in range(T.shape[0]):
        for j in range(T.shape[1]):
            T[i][j] = (1-t)*bao[i][j] + t*sutu[i][j]
    cv2.imshow('Result_img', T)
    cv2.waitKey(1)


