
import cv2
import numpy as np

def correllation(img,kernel,s=1,p=0):
    img_size = img.shape
    kernel_size = kernel.shape
    output=cv2.resize(img,(img_size[1]-kernel_size[1]+1,img_size[0]-kernel_size[0]+1))
    for i in range(0,img_size[0]-kernel_size[0]+1):
        for j in range(0,img_size[1] - kernel_size[1] + 1):
            output[i,j]=( img[i:i+kernel_size[0],j:j+kernel_size[1]]*kernel ).sum()/(((img[i:i+kernel_size[0],j:j+kernel_size[1]]**2).sum()*(kernel**2).sum()))**(1/2)
    return output


def TemlateMatchingUseCorrelation(img,kernel):

    k = kernel.copy()
    k=k/255
    img1 = img.copy()
    img1=img1/255
    out = correllation(img1, k)

    m = out.max()
    pixel_max = np.array([m, m, m])
    vitri_max = []
    for i in range(0, out.shape[0],5):
        for j in range(0, out.shape[1],5):
            if out[i, j, 0] >0.991*pixel_max[0]:
                vitri_max.append([i, j])

    for rectangle in vitri_max:
        cv2.rectangle(img1, (rectangle[1], rectangle[0]),
                      (rectangle[1] + kernel.shape[1], rectangle[0] + kernel.shape[0]), (255, 0, 255), 3)
    return img1


img=cv2.imread('9-ro.jpeg')
img=cv2.resize(img,(400,500))
k = cv2.imread('template.png')

result2=TemlateMatchingUseCorrelation(img,k)
cv2.imshow('TemlateMatchingUseCorrelation',result2)
cv2.waitKey(0)







