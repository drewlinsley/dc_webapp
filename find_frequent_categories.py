from get_clickmaps import return_image_data
from im_lists import dogs, birds, cars, plants, boats, animals, non_animals

basic_groups = {
    'dog' : dogs,
    'bird' : birds,
    'car' : cars,
    'boat' : boats,
    'plant' : plants,
    'animal' : animals,
    'non_animal' : non_animals
}

def customize_groups(image_category):
    return dict((k, v) for k, v in basic_groups.iteritems() if k is image_category)

def bin_clicks(basic_groups, syn_names):
    kept_groups = dict((k, []) for k in basic_groups.iterkeys())
    trash = []
    for k, val in basic_groups.iteritems():
        for row in syn_names:
            if row in val:
                kept_groups[k].append(row)
            else:
                trash.append(row)
    return kept_groups, trash

def main():
    curr_gen, consolidated_clicks, image_info, \
        unique_image_ids, image_types, test_images, num_clicks, clicks, total_image_info = \
        return_image_data()
    total_image_info = [x[0] for x in total_image_info]
    syn_names = [x[1] for x in total_image_info]
    basic_group_image_bins, trash = bin_clicks(basic_groups, syn_names)
    basic_group_counts = [len(v) for v in basic_group_image_bins.itervalues()]
    return basic_group_image_bins, basic_group_counts