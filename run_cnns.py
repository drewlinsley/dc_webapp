import numpy as np
import os, sys
os.environ['CUDA_VISIBLE_DEVICES'] = '0' # Run only on GPU 0 to speed up init time


def list_permutations(la,lb):
    perms = []
    for ii in la:
        for jj in lb:
            perms.append(ii + '_' + jj)
    return perms


model_path = '/home/drew/Documents/mlnet/' 
cnn_path = '/home/drew/Documents/tensorflow-vgg/experiments/MIRC_tests/'
cnn_models = ['vgg16','vgg19']
cnn_types = ['baseline','attention']

#Import program for finetuning click model
sys.path.append(model_path)
#Create list of programs, then add them to the path as needed
sys.path.append(cnn_path)
programs = list_permutations(cnn_types,cnn_models)
for pr in programs:
    
