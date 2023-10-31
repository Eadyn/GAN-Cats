import os 
from PIL import Image

for i in os.listdir("./Data"):
    width, height = Image.open("./Data/" + i).size
    if (width < 256 or height < 256): # If image is below 256 x 256
        os.remove("./Data/" + i)