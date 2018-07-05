from skimage.io import imread
import time

from algorithm import GEFolki
from tools import wrapData


t0 = time.time()

#################
# Open all data #
#################

im1 = imread('../datasets/ew_1.tif')
im2 = imread('../datasets/ew_2.tif')

################
# im2 over im1 #
################

# Compute the flow
u, v = GEFolki(im1, im2, iteration=2, radius=range(32, 4, -4),
               rank=4, levels=6)

# Resample the image
im2_resampled = wrapData(im2, u, v)


print("Elapsed : %f" % time.time() - t0)
