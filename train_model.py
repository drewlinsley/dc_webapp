import os, sys, psycopg2, credentials, json, re, argparse
import numpy as np
os.environ["THEANO_FLAGS"] = "mode=FAST_RUN,device=gpu3,floatX=float32"
from data_proc_config import project_settings
from glob import glob
from scipy import misc
from get_clickmaps import return_image_data
from matplotlib import pyplot as plt
from matplotlib.colors import ListedColormap

def create_clickmaps(obj,im_name,num_clicks,im_size,training_map_path,base_image_path,overlay_path,click_box_radius,cm,produce_heatmaps=True):
    canvas = np.zeros((im_size))
    xs = np.asarray([int(np.round(float(x))) for x in obj['x']])
    ys = np.asarray([int(np.round(float(y))) for y in obj['y']])
    for idx in range(len(xs)): #transpose clicks for js -> python
        canvas[ys[idx] - click_box_radius : ys[idx] + click_box_radius,
            xs[idx] - click_box_radius : xs[idx] + click_box_radius] = \
            canvas[ys[idx] - click_box_radius : ys[idx] + click_box_radius,
            xs[idx] - click_box_radius : xs[idx] + click_box_radius] + 1  #accumulate signal at this spot           
    canvas /= np.max(canvas)
    proc_im_name = re.split('/',im_name)[-1] 
    misc.imsave(training_map_path + proc_im_name, canvas) #Save the clickmap as an image
    if produce_heatmaps:
        #Also produce an overlay
        im = misc.imread(os.path.join(base_image_path,im_name))   
        fig,ax = plt.subplots(nrows=1,ncols=1)
        plt.imshow(im,cmap=plt.cm.gray);
        axis = plt.imshow(canvas,cmap=cm,vmin=0,vmax=1)
        fig.colorbar(axis)
        ax.get_xaxis().set_ticks([])
        ax.get_yaxis().set_ticks([])
        if num_clicks == 1:
            plt.title(proc_im_name + '; %s participant' % int(num_clicks))
        else:
            plt.title(proc_im_name + '; %s participants' % int(num_clicks))
        plt.savefig(os.path.join(overlay_path,proc_im_name))
    return proc_im_name 

def create_directories(dir_list):
    for d in dir_list:
        if not os.path.exists(d):
            os.makedirs(d)

def create_alpha_cmap(alpha=0.5):
    cmap = plt.cm.Reds
    my_cmap = cmap(np.arange(cmap.N))
    my_cmap[:, -1] = np.hstack((0, np.zeros(cmap.N - 1) + alpha))
    return ListedColormap(my_cmap)

def main(generations=None):
    #Get paths and settings
    p = project_settings()
    
    #Create the output directories if they don't exist
    create_directories([p.training_map_path,p.click_overlay_path])

    #Run program for finetuning click model and producing predicted click maps
    sys.path.append(p.model_path)
    import fine_tuning
    curr_gen,image_ids,clicks,click_info,keep_index,kept_image_ids,image_info,image_types,num_clicks = return_image_data(generations=generations)
    cm = create_alpha_cmap()
    map_names = [create_clickmaps(clicks[x]['clicks'],image_info[x][0],num_clicks[x],[256,256],p.training_map_path,p.image_base_path,p.click_overlay_path,p.click_box_radius,cm) for x in range(len(clicks))]
    import ipdb;ipdb.set_trace()
    abs_path = os.path.dirname(os.path.abspath(__file__)) + '/'

    #Fine tuning first
    training_images = [abs_path + p.training_image_path + x for x in map_names]
    training_maps = [abs_path + p.training_map_path + x for x in map_names] 
    test_images = glob(p.validation_image_path + p.im_ext)
    checkpoint_path,prediction_paths = fine_tuning.finetune_model(p.model_path,p.nb_epoch,p.train_iters,p.val_iters,training_images,training_maps,p.model_init_training_weights,p.model_checkpoints,test_images,p.model_path + p.click_map_predictions)

    #Produce predictions
    #attention_predictions = fine_tuning.produce_maps(p.model_init_training_weights,checkpoint_path,test_images,p.model_path + p.click_map_predictions) #Save these in the model's directory

    #run_cnns.py needs to be run to enter new accuracies into the database

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--generations',dest='generations',default=True,help='Defaults to processing the most recent generation. Pass anything to include all data')
    args = parser.parse_args() 
    main(**vars(args))
