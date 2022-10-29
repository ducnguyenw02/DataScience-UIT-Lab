import cv2

tony_stark = cv2.imread('CS231/Buoi01/tonystark.jpg') # Doc anh 
ironman = cv2.imread('CS231/Buoi01/ironman.jpg')

#print(ironman.shape)
ironman_new = ironman[0:801, 300:300+801, : ]
tony_stark_new = tony_stark[0:801, 300:300+801, : ]
cv2.imwrite('CS231/Buoi01/CS231/ironman_new.jpg', ironman_new)
cv2.imwrite('CS231/Buoi01/CS231/tony_stark_new.jpg', tony_stark_new)

# Su dung 2 buc anh la View va ironman_new
tony_stark_new_copy = tony_stark_new.copy() 
ironman_new_copy = ironman_new.copy()

# Animation push left
ironman_new[:,:] = ironman_new_copy[:,:]
H = ironman_new.shape[1] 

for D in range(H, 0, -1):
    ironman_new[:, D:] = ironman_new_copy[:, 0:H-D]
    ironman_new[:, 0:D] = tony_stark_new_copy[:, H-D:]

    cv2.imshow('Viewww', ironman_new)
    cv2.waitKey(1)

# Animation uncover
ironman_new[:,:] = ironman_new_copy[:,:]
H = ironman_new.shape[1] 

for D in range(H, 0, -1):
    ironman_new[:, D:H] = tony_stark_new_copy[:, D:H]
    ironman_new[:, 0:D] = tony_stark_new_copy[:, H-D:]
    cv2.imshow('Viewww', ironman_new)
    cv2.waitKey(1)

# Animation push down
ironman_new[:,:] = ironman_new_copy[:,:]
H = ironman_new.shape[0] 

for D in range(0, H, 1):
    ironman_new[D:,:] = ironman_new_copy[0:H-D,:]
    ironman_new[0:D,:] = tony_stark_new_copy[H-D:,:]

    cv2.imshow('Viewww', ironman_new)
    cv2.waitKey(1)

# Animation push up
ironman_new[:,:] = ironman_new_copy[:,:]
H = ironman_new.shape[0] 

for D in range(H, 0, -1):
    ironman_new[D:,:] = ironman_new_copy[0:H-D,:]
    ironman_new[0:D,:] = tony_stark_new_copy[H-D:,:]

    cv2.imshow('Viewww', ironman_new)
    cv2.waitKey(1)

#Animation cover 
ironman_new[:,:] = ironman_new_copy[:,:]
H = ironman_new.shape[0] 

for D in range(0,H, 1):
    ironman_new[:,D:H] = ironman_new_copy[:,D:H]
    ironman_new[:,H-D:] = tony_stark_new_copy[:,0:D]

    cv2.imshow('Viewww', ironman_new)
    cv2.waitKey(1)



