import cv2
import numpy as np

img = cv2.imread('Screen Shot 2022-12-19 at 13.43.13.png', 0)
a,img = cv2.threshold(img, 100, 255, cv2.THRESH_BINARY_INV)

kernel = np.ones((12, 12), np.uint8)
img_erosion = cv2.erode(img, kernel, iterations=2)
img_dilation = cv2.dilate(img_erosion, kernel, iterations=1)

kernel = np.ones((10, 10), np.uint8)
img_erosion = cv2.erode(img_dilation, kernel, iterations=1)

output = cv2.connectedComponentsWithStats(img_erosion, cv2.CV_32S)
(numLabels, labels, stats, centroids) = output

print("Số lượng tế bào:",numLabels)

cv2.imshow('result', img_erosion)
cv2.waitKey(0)
cv2.destroyAllWindows()