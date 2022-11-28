import cv2
import numpy as np

img = cv2.imread('maunen.jpg')

r_min = np.min(img[:,:,0])-20
g_min = np.min(img[:,:,1])-20
b_min = np.min(img[:,:,2])-20

r_max = np.max(img[:,:,0])+25
g_max = np.max(img[:,:,1])+25
b_max = np.max(img[:,:,2])+25

img_test = cv2.imread('people.jpg')

for i in range(img_test.shape[0]):
    for j in range(img_test.shape[1]):
        if r_min < img_test[i][j][0] and img_test[i][j][0] < r_max and g_min < img_test[i][j][1] and img_test[i][j][1] < g_max and b_min < img_test[i][j][2] and img_test[i][j][2] < b_max :
            img_test[i][j][:] = [150,150,150]

cv2.imshow('img', img_test)
cv2.waitKey(0)
