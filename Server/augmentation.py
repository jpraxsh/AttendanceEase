from keras.preprocessing.image import ImageDataGenerator
from skimage import io
datagen = ImageDataGenerator(        
        rotation_range = 40,
        
        zoom_range = 0.2,
        horizontal_flip = True,
        brightness_range = (0.3, 2))
import numpy as np
import os
from PIL import Image
image_directory = r'finalML/training/2020503530/'
SIZE = 224
dataset = []
my_images = os.listdir(image_directory)
for i, image_name in enumerate(my_images):    
    if (image_name.split('.')[1] == 'jpg'):        
        image = io.imread(image_directory + image_name)        
        image = Image.fromarray(image, 'RGB')        
        image = image.resize((SIZE,SIZE)) 
        dataset.append(np.array(image))
x = np.array(dataset)
i = 0
for batch in datagen.flow(x, batch_size=16,
                          save_to_dir= r'finalML/frames',
                          save_prefix='prak',
                          save_format='jpg'):    
    i += 1    
    if i > 50:        
        break