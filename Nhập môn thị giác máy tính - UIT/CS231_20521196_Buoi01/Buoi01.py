import cv2
import numpy as np
import matplotlib
import sys

tony_stark = cv2.imread('CS231/Buoi01/tonystark.jpg') # Doc anh 
ironman = cv2.imread('CS231/Buoi01/ironman.jpg')

print(ironman.shape)
ironman_new = ironman[0:801, 300:300+801, : ]
tony_stark_new = tony_stark[0:801, 300:300+801, : ]
cv2.imwrite('CS231/Buoi01/ironman_new.jpg', ironman_new)
cv2.imwrite('CS231/Buoi01/tony_stark_new.jpg', tony_stark_new)



cv2.imshow('Viewww', tony_stark_new) # Hien thi anh
cv2.waitKey(1000) # Hien thi thoi gian anh  
# Tang do sang buc anh 
def change_brightness(img, beta):
    img_new = np.asarray(1.0*img + beta, dtype=int)   # cast pixel values to int
    img_new[img_new>255] = 255
    img_new[img_new<0] = 0
    return img_new

beta = 50
tonystark_new_01 = change_brightness(tony_stark_new, beta)


cv2.imwrite('CS231/Buoi01/tonystark01.jpg', tonystark_new_01)
tonystark_new_01 = cv2.imread('CS231/Buoi01/tonystark01.jpg')


cv2.imshow('Viewww', tonystark_new_01)
cv2.waitKey(1000)

# Lat anh theo hang doc
tonystark_new_02 = np.flip(tony_stark_new, axis= 0)
cv2.imwrite('CS231/Buoi01/tonystark02.jpg', tonystark_new_02)
cv2.imshow('Viewww', tonystark_new_02)
cv2.waitKey(1000)

# Lat anh theo hang ngang 
tonystark_new_03 = np.flip(tony_stark_new, axis= 1)
cv2.imwrite('CS231/Buoi01/tonystark03.jpg', tonystark_new_03)
cv2.imshow('Viewww', tonystark_new_03)
cv2.waitKey(1000)

# Su dung 2 buc anh la View va ironman_new
tony_stark_new_copy = tony_stark_new.copy() 
ironman_new_copy = ironman_new.copy()


# Animation 1
ironman_new[:,:] = ironman_new_copy[:,:]
H = ironman_new.shape[0] 

for D in range(0, H, 3):
    ironman_new[D:,:] = ironman_new_copy[0:H-D,:]
    ironman_new[0:D,:] = tony_stark_new_copy[H-D:,:]

    cv2.imshow('Viewww', ironman_new)
    cv2.waitKey(1)

# Animation 2
ironman_new[:,:] = ironman_new_copy[:,:]
H = ironman_new.shape[1] 

for D in range(0, H, 3):
    ironman_new[:, D:] = ironman_new_copy[:, 0:H-D]
    ironman_new[:, 0:D] = tony_stark_new_copy[:, H-D:]

    cv2.imshow('Viewww', ironman_new)
    cv2.waitKey(1)

# Animation 3
ironman_new[:,:] = ironman_new_copy[:,:]
H = int(ironman_new.shape[1]/2)

for D in range(0, H, 2):
    ironman_new[:, H-D:H+D] = tony_stark_new_copy[:, H-D:H+D]

    cv2.imshow('Viewww', ironman_new)
    cv2.waitKey(1)

# Animation 4
ironman_new[:,:] = ironman_new_copy[:,:]
H = int(ironman_new.shape[0]/2)

for D in range(0, H, 2):
    ironman_new[H-D:H+D, :] = tony_stark_new_copy[H-D:H+D, :]

    cv2.imshow('Viewww', ironman_new)
    cv2.waitKey(1)

# Animation 5 
ironman_new[:,:] = ironman_new_copy[:,:]
H0 = int(ironman_new.shape[0]/2)
H1 = int(ironman_new.shape[1]/2)

for D in range(0, H1, 2):
    ironman_new[H0-D:H0+D, H1-D:H1+D] = tony_stark_new_copy[H0-D:H0+D, H1-D:H1+D]
    
    cv2.imshow('Viewww', ironman_new)
    cv2.waitKey(1)

# Animation 6
ironman_new = ironman_new_copy
H = ironman_new.shape[0] 

for D in range(0, H, 3):
    ironman_new[D:,:] = ironman_new_copy[0:H-D,:]
    ironman_new[0:D,:] = tony_stark_new_copy[H-D:,:]

    cv2.imshow('Viewww', ironman_new)
    cv2.waitKey(1)

# Animation 7
ironman_new = ironman_new_copy
H = ironman_new.shape[1] 

for D in range(0, H, 3):
    ironman_new[:, D:] = ironman_new_copy[:, 0:H-D]
    ironman_new[:, 0:D] = tony_stark_new_copy[:, H-D:]

    cv2.imshow('Viewww', ironman_new)
    cv2.waitKey(1)








