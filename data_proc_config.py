import os 

class Map(dict):
    """
    Example:
    m = Map({'first_name': 'Eduardo'}, last_name='Pool', age=24, sports=['Soccer'])
    """
    def __init__(self, *args, **kwargs):
        super(Map, self).__init__(*args, **kwargs)
        for arg in args:
            if isinstance(arg, dict):
                for k, v in arg.iteritems():
                    self[k] = v

        if kwargs:
            for k, v in kwargs.iteritems():
                self[k] = v

    def __getattr__(self, attr):
        return self.get(attr)

    def __setattr__(self, key, value):
        self.__setitem__(key, value)

    def __setitem__(self, key, value):
        super(Map, self).__setitem__(key, value)
        self.__dict__.update({key: value})

    def __delattr__(self, item):
        self.__delitem__(item)

    def __delitem__(self, key):
        super(Map, self).__delitem__(key)
        del self.__dict__[key]

def project_settings():
    node_name = os.uname()[1]

    if node_name == 'x8':
        model_path = '/media/data_gluster/attention/mlnet/'
        tf_path = '/media/data_gluster/attention/tf_experiments/'
        image_base_path = '/media/data_cifs/clicktionary/webapp_data/'
    elif node_name == 'x9':
        model_path = '/home/drew/Documents/mlnet/'
        tf_path = '/home/drew/Documents/tf_experiments/'
    elif node_name == 'g15':
        model_path = '/home/drew/clickmap_prediction/'
        tf_path = '/home/drew/tf_experiments/'
        image_base_path = '/media/data_clicktionary/webapp_data/'
    else:
        model_path = '/home/youssef/clickmap_prediction/'
        tf_path = '/home/youssef/tf_experiments/'
        image_base_path = '/media/data_cifs/clicktionary/webapp_data/'

    mirc_image_path = os.path.join(image_base_path, 'mircs')
    nsf_image_path = os.path.join(image_base_path, 'nsf_images')
    imagenet_train_path = os.path.join(image_base_path, 'lmdb_trains')
    imagenet_validation_path = os.path.join(image_base_path, 'lmdb_validations')

    d = {
    #Images for the click map prediction and folders for saving the predictions
    'training_map_path' : 'database_click_images/',
    'click_map_predictions' : 'model_click_predictions/',
    'validation_image_path' : imagenet_validation_path,#'validation_images/', #Originally we just used these files
    'training_image_path' : 'images/',
    'im_ext' : '.JPEG',
    'imagenet_train_path' : imagenet_train_path, #Now combine a subset of these, with a subset of validation_image_path, and the below 10 images
    'mirc_image_path' : mirc_image_path,
    'nsf_image_path' : nsf_image_path,
    'image_base_path' : image_base_path,

    # Epoch training
    'click_box_radius' : 9,
    'iterations_per_generation' : 4, # Number of annotations per images until we re-train
    'train_iters' : 10000, #not implemented yet
    'val_iters' : 100, #not implemented yet
    'nb_epoch' : 1,

    #For finetuning the click predictor
    'model_path' : model_path,
    'model_init_training_weights' : model_path + 'models',
    'model_checkpoints' : model_path + 'model_checkpoints',

    #Paths for testing CNNs with attention maps
    'tf_path' : tf_path,
    'cnn_path' : tf_path + 'experiments/MIRC_webapp/',
    'cnn_model_path' : tf_path + 'pretrained_weights/',
    'cnn_architecture_path' : tf_path + 'model_depo/',
    'part_syn_file_path' : tf_path + 'data/ilsvrc_2012/synset_names.txt',
    'full_syn_file_path' : tf_path + 'data/ilsvrc_2012/synset.txt',
    'cnn_models' : ['vgg16'],#['vgg16','vgg19'],
    'cnn_types' : ['baseline','attention']
    }
    d = Map(d)

    #Make this directory if it doesn't exist yet
    if not os.path.exists(d.training_map_path):
        os.makedirs(d.training_map_path)

    return d

