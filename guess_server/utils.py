#!/usr/bin/env python
# Utility functions for CNN server

import os
from datetime import timedelta
from flask import make_response, request, current_app
from functools import update_wrapper
import numpy as np
import skimage.io
from scipy.misc import imresize

# Image loader that keeps resizes+crops image and keeps last n images cached in memory
class ImageCache:
    def __init__(self, data_path, max_cache_size=10, input_size=(256, 256, 3), crop_size=(224, 224)):
        self.data_path = data_path
        self.cached_images = {}
        self.cached_last_accessed = {}
        self.access_counter = 0
        self.max_cache_size = max_cache_size
        self.input_size = tuple(input_size)
        self.crop_size = crop_size
        self.crop_margin = [(i - c) / 2 for (i, c) in zip(self.input_size[:2], self.crop_size)]

    def load_image(self, filename):
        # Load image in TF format
        full_filename = os.path.join(self.data_path, filename)
        image = skimage.io.imread(full_filename) / 255.0
        # Grayscale to RGB
        if len(image.shape) == 2: image = np.dstack((image,) * 3)
        if image.shape != self.input_size:
            # Resize to fit model
            print '  Reshaping image %s from %s to %s.' % (filename, str(image.shape), str(self.input_size))
            image = imresize(image, self.input_size)
        # Crop
        image = image[self.crop_margin[0]:self.crop_margin[0]+self.crop_size[0], self.crop_margin[1]:self.crop_margin[1]+self.crop_size[1],:]
        return image

    def get_image(self, filename):
        # Check cache
        image = self.cached_images.get(filename)
        if image is None:
            # Not in cache: Load image
            if len(self.cached_images) == self.max_cache_size:
                # Cache full. Remove oldest from cache before loading next image.
                oldest_filename = min(self.cached_last_accessed, key=self.cached_last_accessed.get)
                del self.cached_images[oldest_filename]
                del self.cached_last_accessed[oldest_filename]
                print '  Discarded cached image %s.' % (oldest_filename)
            image = self.load_image(filename)
            print '  Load new cache image  %s.' % (filename)
            self.cached_images[filename] = image
        # Remember cache age
        self.cached_images[filename] = self.access_counter
        return image
