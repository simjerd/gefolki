
from scipy import signal
from scipy import ndimage

USE_LINEAR = True


if USE_LINEAR:
    interp2 = lambda I, x, y : ndimage.map_coordinates(I, [y, x], order=1, mode='nearest').reshape(I.shape)
else:
    interp2 = lambda I, x, y : ndimage.map_coordinates(I, [y, x], order=3, mode='nearest')

conv2bis = lambda I, w : signal.convolve2d(I, w, mode='valid')
