import os, sys, re, argparse, glob, subprocess
import numpy as np
os.environ["THEANO_FLAGS"] = "mode=FAST_RUN,device=gpu3,lib.cnmem=0.95,floatX=float32"
from data_proc_config import project_settings
from scipy import misc
from get_clickmaps import return_image_data
from matplotlib import pyplot as plt
from matplotlib.colors import ListedColormap

def create_clickmaps(obj,im_name,num_clicks,im_size,training_map_path,base_image_path,overlay_path,click_box_radius,cm,overlays):
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
    if overlays:
        #Also produce an overlay if we have multiple clicks
        if num_clicks > 1:
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
    return im_name 

def create_directories(dir_list):
    for d in dir_list:
        if not os.path.exists(d):
            os.makedirs(d)

def create_alpha_cmap(alpha=0.5):
    cmap = plt.cm.Reds
    my_cmap = cmap(np.arange(cmap.N))
    my_cmap[:, -1] = np.hstack((0, np.zeros(cmap.N - 1) + alpha))
    return ListedColormap(my_cmap)

def main(generations,overlays):
    #Get paths and settings
    p = project_settings()
    
    #Create the output directories if they don't exist
    create_directories([p.training_map_path,p.click_overlay_path])

    #Run program for finetuning click model and producing predicted click maps
    sys.path.append(p.model_path)
    curr_gen,consolidated_clicks,consolidated_image_info,unique_image_ids,image_types,num_clicks = \
        return_image_data(generations=generations)
    cm = create_alpha_cmap()
    import fine_tuning
    map_names = [create_clickmaps(consolidated_clicks[x]['clicks'],consolidated_image_info[x][0],\
        num_clicks[x],p.image_size,p.training_map_path,p.image_base_path,p.click_overlay_path,\
        p.click_box_radius,cm,overlays=overlays) for x in range(len(consolidated_clicks))]
    abs_path = os.path.dirname(os.path.abspath(__file__)) + '/'

    # Fine tuning first
    training_images = [os.path.join(p.image_base_path,x) for x in map_names]
    training_maps = [os.path.join(abs_path,p.training_map_path + re.split('/',x)[-1]) for x in map_names] 
    if p.nb_epoch == 0:
        # Using the most recent model
        most_recent_folder = max(glob.iglob(os.path.join(p.model_path, p.model_checkpoints,'*')), key=os.path.getctime)
        checkpoint_path = max(glob.iglob(os.path.join(most_recent_folder,'*.h5')), key=os.path.getctime)
    else:
        checkpoint_path = fine_tuning.finetune_model(p.model_path,p.nb_epoch,p.train_iters,p.val_iters,training_images,training_maps,p.model_init_training_weights,p.model_checkpoints,p.model_path + p.click_map_predictions)

    # Produce predictions and compare them to heatmaps on the clicktionary images
    test_images = glob.glob(os.path.join(p.clicktionary_paper_images,'*' + p.im_ext))
    attention_predictions = fine_tuning.produce_maps(p.model_init_training_weights,checkpoint_path,test_images,p.model_path + p.click_map_predictions) #Save these in the model's directory
    [subprocess.Popen(["scp", x, "clickme@g15:/home/clickme/python/dc_webapp/database_click_images/"]).wait() for x in attention_predictions]
    os.system("scp %s clickme@g15:/home/clickme/python/dc_webapp/database_click_images/%s")
    return attention_predictions
    # run_cnns.py needs to be run to enter new accuracies into the database

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--generations',dest='generations',default=None,help='Pass an integer to target a specific generation.')
    parser.add_argument('--overlays',dest='overlays',default=False,help='Produce overlays. Defaults to false.')
    args = parser.parse_args() 
    main(**vars(args))
