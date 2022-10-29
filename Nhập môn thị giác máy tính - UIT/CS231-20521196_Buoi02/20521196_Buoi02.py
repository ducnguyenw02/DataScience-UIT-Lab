import cv2
import imageio
import numpy as np 
from PIL import Image
def phatronanhtinh(duc_foreground, duc_mask, effect):
    # Chuẩn hóa cả 3 ảnh về cùng kích thước 450x450
    effect_resize = cv2.resize(effect, (450,450))
    duc_mask_resize = cv2.resize(duc_mask, (450,450))
    duc_foreground_resize = cv2.resize(duc_foreground, (450,450))

    # Pha trộn hình ảnh 
    result = duc_foreground_resize.copy()
    alpha = 0.6
    result[duc_mask_resize[:,:,3] != 0] = duc_foreground_resize[duc_mask_resize[:,:,3] != 0] * alpha \
        + effect_resize[duc_mask_resize[:,:,3] != 0] * (1 - alpha)

    cv2.imshow('Result_img', result)
    cv2.waitKey(2000)

    # Lưu ảnh 
    cv2.imwrite('CS231-20521196_Buoi02/result_img.jpg', result)

def phatronanhdong(duc_foreground, duc_mask, frames):
    # Chuẩn hóa ảnh thành kích thước 400x400
    duc_mask_resize = cv2.resize(duc_mask, (450,450))
    duc_foreground_resize = cv2.resize(duc_foreground, (450,450))

    duc_foreground_resize_h, duc_foreground_resize_w, duc_foreground_resize_c = duc_foreground_resize.shape
    bg_h, bg_w, bg_c = frames[0].shape
    top = int((bg_h-duc_foreground_resize_h)/2)
    left = int((bg_w-duc_foreground_resize_w)/2)
    bgs = [frame[top: top + duc_foreground_resize_h, left:left + duc_foreground_resize_w, 0:3] for frame in frames]

    results = [] # Kết quả cuối cùng khi kết hợp ảnh foregound với gif
    alpha = 0.6
    for i in range(len(bgs)): 
        if i%10 ==0: # Đổi màu hiệu ứng, # Mỗi 10 ảnh cắt ra từ gif, thì 5 ảnh sẽ đổi màu, 5 ảnh giữ nguyên màu
            bgs[i][:,:,1] = 0
            bgs[i+1][:,:,1] = 0
            bgs[i+2][:,:,1] = 0
            bgs[i+3][:,:,1] = 0
            bgs[i+4][:,:,1] = 0

        result = duc_foreground_resize.copy()
        result[duc_mask_resize[:,:,3] != 0] = alpha * result[duc_mask_resize[:,:,3] != 0]
        result[duc_mask_resize[:,:,3] == 0] = (alpha - 0.3) * result[duc_mask_resize[:,:,3] == 0]
        bgs[i][duc_mask_resize[:,:,3] == 0 ] = (alpha + 0.1)* bgs[i][duc_mask_resize[:,:,3] == 0 ]
        bgs[i][duc_mask_resize[:,:,3] != 0] = (1-alpha)*bgs[i][duc_mask_resize[:,:,3] != 0]
        result = result + bgs[i]
        rgb_result = cv2.cvtColor(result, cv2.COLOR_BGR2RGB) 
        results.append(rgb_result)

    imageio.mimsave('CS231-20521196_Buoi02/result_gif.gif', results)


# Đọc ảnh 
duc_foreground = cv2.imread('CS231-20521196_Buoi02/duc_foreground.jpg')
duc_mask = cv2.imread('CS231-20521196_Buoi02/duc_mask.png', cv2.IMREAD_UNCHANGED)
effect = cv2.imread('CS231-20521196_Buoi02/effect_fire.jpg')

# Đọc gif (ảnh động từ web)

url = "https://media0.giphy.com/media/x3WB8RoVGKFu9QmIoW/giphy.gif"
frames = imageio.mimread(imageio.core.urlopen(url).read(), '.gif')


phatronanhtinh(duc_foreground, duc_mask, effect)
phatronanhdong(duc_foreground, duc_mask, frames)


