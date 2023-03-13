from PIL import Image
import glob
import os

out_dir = 'D:\\OneDrive - California Institute of Technology\\PhD\\Rangel Lab\\2022-surprise-utility\\task\\rewards-online'
cnt = 1
for img in glob.glob('D:\\OneDrive - California Institute of Technology\\PhD\\Rangel Lab\\2022-surprise-utility\\task\\rewards\\*.bmp'):
    Image.open(img).save(os.path.join(out_dir, str(cnt) + '.png'))
    cnt += 1