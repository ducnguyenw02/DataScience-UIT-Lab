import cv2
import numpy as np
import matplotlib.pyplot as plt

def deg2grad(deg):
    return deg*3.141592654/180
# Step 0.5: initialize hough table
theta_range = np.arange(-3.14, 3.14, 0.01)
H = np.zeros((520*2+1, len(theta_range)), dtype=np.uint8)
  
# Step 1: accumulate hough space
list_pro_theta = []
def accumulate(point):
    #for theta in range(360):
    for theta in theta_range:
        pro = point[0]*np.cos(theta) + point[1]*np.sin(theta)
        # If pro in range of Hough space
        if pro >= 0 and pro < 520*2+1:
            # map theta to Hough space
            # (theta - (-3.14))/0.01
            H[int(pro), int((theta + 3.14)/0.01)] +=1
            list_pro_theta.append([int(pro), int((theta + 3.14)/0.01)])
    return H

def step_4():
    list_H = []
    for list in list_pro_theta:
        if H[list[0], list[1]] > 140:
            list_H.append([list[0], list[1]])

    for i in range(len(list_H)):
        list_H[i][1] = (list_H[i][1])*0.01 -3.14

    return list_H

def main():

    src = cv2.imread('sanbong.png', cv2.IMREAD_COLOR)
    gray = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY) # color -> gray
    edges = cv2.Canny(gray, 500, 650, apertureSize=3)

    list = np.squeeze(cv2.findNonZero(edges))
    for i in range(len(list)):
        accumulate(list[i])

    list_H = step_4()
    for line in list_H:
        rho, theta = line[0], line[1]
        a = np.cos(theta)
        b = np.sin(theta)
        x0 = a*rho
        y0 = b*rho
        x1 = int(x0 + 1000*(-b))
        y1 = int(y0 + 1000*(a))
        x2 = int(x0 - 1000*(-b))
        y2 = int(y0 - 1000*(a))
        cv2.line(src,(x1,y1),(x2,y2),(255,0,0),2)   
    
    cv2.imshow("Hough space visualization", src)
    cv2.waitKey(0)


if __name__ == "__main__":
    main()





