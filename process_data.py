import os 
import PIL
from PIL import Image

newIndex = 0
for i in os.listdir("./Data"):
    try:
        width, height = Image.open("./Data/" + i).size
        if (width < 256 or height < 256): # If image is below 256 x 256
            # print("Removing Small Image:", i)
            os.remove("./Data/" + i)
            continue
    except PIL.UnidentifiedImageError:
        # print("Removing Corrupt Image:", i)
        os.remove("./Data/" + i)
        continue

    os.rename("./Data/" + i,f"./Data/CAT-{str(newIndex)}.jpg")
    newIndex += 1
