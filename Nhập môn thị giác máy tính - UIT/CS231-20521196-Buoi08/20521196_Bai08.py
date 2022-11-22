import cv2
import numpy as np

img = cv2.imread('sanbong.jpg')
img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
cv2.imshow('input', img)
unique, count = np.unique(img, return_counts=True)
out = [[unique[i], count[i]] for i in range (0,len(unique))]
cdf = [count[0]]
for i in range (1,len(unique)):
    cdf.append(cdf[i-1] + count[i])
outa = [[unique[i], cdf[i]] for i in range (0,len(unique))]
outb = [round((cdf[i] - min(cdf)) * 255 / (max(cdf) - min(cdf))) for i in range (0,len(unique))]
xmax, ymax = np.shape(img)
for x in range (0, xmax):
    for y in range (0, ymax):
        for i in range (0,len(unique)):
            if img[x][y] == unique[i]:
                img[x][y] = outb[i]
                break
cv2.imshow('results', img)
cv2.waitKey(0)