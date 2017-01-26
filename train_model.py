import os, sys, re, argparse, glob, subprocess, math, time
import numpy as np
from data_proc_config import project_settings
from scipy import misc
from get_clickmaps import return_image_data
from matplotlib import pyplot as plt
from matplotlib.colors import ListedColormap

def create_clickmaps(obj, im_name, num_clicks, im_size, training_map_path,\
    base_image_path, overlay_path, click_box_radius, cm, overlays,\
    convert_to_uint8=True):
    canvas = np.zeros((im_size))
    xs = np.asarray([int(np.round(float(x))) for x in obj['x']])
    ys = np.asarray([int(np.round(float(y))) for y in obj['y']])
    for idx in range(len(xs)):  # transpose clicks for js -> python
        canvas[ys[idx] - click_box_radius : ys[idx] + click_box_radius,
            xs[idx] - click_box_radius : xs[idx] + click_box_radius] = \
            canvas[ys[idx] - click_box_radius : ys[idx] + click_box_radius,
            xs[idx] - click_box_radius : xs[idx] + click_box_radius] + 1  #accumulate signal at this spot           
    canvas /= np.max(canvas)
    if convert_to_uint8:
        canvas = (canvas * 255).astype('uint8')
    split_im_name = re.split('/',im_name)
    proc_im_name = split_im_name[-1]
    proc_im_type = split_im_name[0]
    misc.imsave(training_map_path + proc_im_name, canvas) #Save the clickmap as an image; alternatively insert tfrecords/lmdb creation here
    if overlays:
        # Also produce an overlay if we have multiple clicks
        if proc_im_type in overlays:
            im = misc.imread(os.path.join(base_image_path,im_name))
            plot_overlays(proc_im_name, overlay_path, num_clicks, im, canvas, cm, convert_to_uint8=convert_to_uint8)
    return im_name

def plot_overlays(proc_im_name, overlay_path, num_clicks, test_image, canvas, cm, convert_to_uint8=False):
    fig, ax = plt.subplots(nrows=1, ncols=1)
    plt.imshow(test_image, cmap=plt.cm.gray)
    if convert_to_uint8:
        canvas = (canvas).astype('float')
        canvas /= np.max(canvas)
    axis = plt.imshow(canvas, cmap=cm, vmin=0, vmax=1)
    fig.colorbar(axis)
    ax.get_xaxis().set_ticks([])
    ax.get_yaxis().set_ticks([])
    if num_clicks == 1:
        plt.title(proc_im_name + '; %s participant' % int(num_clicks))
    else:
        plt.title(proc_im_name + '; %s participants' % int(num_clicks))
    plt.savefig(os.path.join(overlay_path,proc_im_name))
    plt.close('all')

def create_directories(dir_list):
    for d in dir_list:
        if not os.path.exists(d):
            os.makedirs(d)

def create_alpha_cmap(alpha=0.5):
    cmap = plt.cm.RdBu_r#plt.cm.Reds
    my_cmap = cmap(np.arange(cmap.N))
    my_cmap[:, -1] = np.hstack((0, np.zeros(cmap.N - 1) + alpha))
    return ListedColormap(my_cmap)

def main(generations,overlays):
    # Get paths and settings
    p = project_settings()
    assert p.batch_size > 0
    timestamp = time.localtime()
    p.dt_string = str(timestamp.tm_mon) + '_' + str(timestamp.tm_mday) + '_' + str(timestamp.tm_hour) + '_' + str(timestamp.tm_min)

    os.environ["THEANO_FLAGS"] = "mode=FAST_RUN,device=gpu%s,lib.cnmem=0.95,floatX=float32" % (p.gpu)
    # Create the output directories if they don't exist
    p.training_map_path = os.path.join(p.training_map_path, p.dt_string)
    p.click_overlay_path = os.path.join(p.click_overlay_path, p.dt_string)
    p.prediction_output_path = os.path.join(p.model_path, p.click_map_predictions)
    p.prediction_overlay_path = os.path.join(p.model_path, p.click_map_overlays)
    create_directories([p.training_map_path, p.click_overlay_path, 
        p.prediction_output_path, p.prediction_overlay_path])

    #Run program for finetuning click model and producing predicted click maps
    sys.path.append(p.model_path)
    _, consolidated_clicks, consolidated_image_info, _, _, test_images, num_clicks, _, _ = \
        return_image_data(generations=generations)
    test_images = test_images[:200]  # hardcoded just to reduce our time in prediction
    cm = create_alpha_cmap()
    import fine_tuning
    overlay_names = ['mircs','nsf'] if overlays else False  # Only look at mircs and nsf images
    map_names = [create_clickmaps(consolidated_clicks[x]['clicks'],consolidated_image_info[x][0],\
        num_clicks[x],p.image_size, p.training_map_path,p.image_base_path,p.click_overlay_path,\
        p.click_box_radius,cm, overlays=overlay_names) for x in range(len(consolidated_clicks))]
    abs_path = os.path.dirname(os.path.abspath(__file__)) + '/'

    # Fine tuning first
    training_images = [os.path.join(p.image_base_path, x) for x in map_names]
    training_maps = [os.path.join(abs_path, p.training_map_path + re.split('/', x)[-1]) for x in map_names]
    p.model_input_shape_r, p.model_input_shape_c
    out_r = int(math.ceil(p.model_input_shape_r / 8))
    out_c = int(math.ceil(p.model_input_shape_c / 8))
    if p.nb_epoch == 0:
        # Using the most recent model
        most_recent_folder = max(glob.iglob(os.path.join(p.model_path, p.model_checkpoints,'*')), key=os.path.getctime)
        checkpoint_path = max(glob.iglob(os.path.join(most_recent_folder,'*.h5')), key=os.path.getctime)
        print 'Reusing model found in ' + checkpoint_path
    else:
        print 'Training model on %s images + realization maps' % len(training_images)
        checkpoint_path = fine_tuning.finetune_model(p, out_r, out_c, training_images, training_maps)

    # Produce predictions and compare them to heatmaps on the clicktionary images
    test_images_paths = [os.path.join(p.image_base_path, x) for x in test_images]
    attention_predictions = fine_tuning.produce_maps(p, checkpoint_path, test_images_paths)
    plot_overlays(test_images, attention_predictions)
    [plot_overlays(test_images[x], p.prediction_overlay_path, num_clicks[x],
            test_images_paths[x], attention_predictions[x], cm) for x in range(len(attention_predictions))]

    [subprocess.Popen(["scp", x, "clickme@g15:/home/clickme/python/dc_webapp/database_click_images/"]).wait() for x in attention_predictions]
    # os.system("scp %s clickme@g15:/home/clickme/python/dc_webapp/database_click_images/%s")
    return attention_predictions
    # run_cnns.py needs to be run to enter new accuracies into the database

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--generations',dest='generations',default=None,help='Pass an integer to target a specific generation.')
    parser.add_argument('--overlays',dest='overlays',default=False,help='Produce overlays. Defaults to false.')
    args = parser.parse_args() 
    main(**vars(args))
