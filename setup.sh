#! /bin/bash
set -e
RED="\033[0;31m"
CYAN="\033[0;36m"
NC="\033[0m"

echo "In order to Download the Datasets, you must have a Kaggle API key."
echo "This script cam assume you have put the kaggle.json file in your Downloads \
 folder and automatically copys it to the correct directoty, \
 setting the correct permissions" 

printf "import kaggle.json from Downloads?:"
read VAR1

VAR2="yes"
if [ "$VAR1" = "$VAR2" ]; then
    echo -e  "$CYAN Installing API key from Downloads Folder $NC"
    cp ~/Downloads/kaggle.json ~/.kaggle/kaggle.json
    chmod 600 ~/.kaggle/kaggle.json
fi


echo "(Re)install Python venv?:"
read VAR1
VAR2="yes"
if [ "$VAR1" = "$VAR2" ]; then
    echo -e "$CYAN Creating Python Virtual Enviroment... \033[0m $NC" 
    rm -r .python
    python3 -m venv ./.python

    echo -e "$CYAN Installing Dependencies... $NC" 
    .python/bin/pip install -r requirements.txt
fi

# Make working Directories
rm -r Data
rm -r OriginalData
mkdir -p OriginalData/set1
mkdir -p OriginalData/set2
mkdir -p Data
# Download Datasets

.python/bin/kaggle datasets download shaunthesheep/microsoft-catsvsdogs-dataset
mv microsoft-catsvsdogs-dataset.zip OriginalData/
.python/bin/kaggle datasets download crawford/cat-dataset
mv cat-dataset.zip OriginalData/

# Unzip Datasets
echo -e  "$CYAN Unzipping Dataset 1... $NC"
unzip -q OriginalData/microsoft-catsvsdogs-dataset.zip -d OriginalData/set1


echo -e  "$CYAN Unzipping Dataset 2... $NC"
unzip -q OriginalData/cat-dataset.zip -d OriginalData/set2

# Clean Datasets
echo -e  "$CYAN Moving Relavent files from Dataset 1 to ./Data... $NC"
cp OriginalData/set1/PetImages/Cat/*.jpg Data

echo -e  "$CYAN Moving Relavent files from Dataset 2 to ./Data... $NC"
for VARIABLE in 0 1 2 3 4 5 6
do
    cp OriginalData/set2/CAT_0$VARIABLE/*.jpg Data
done

echo -e  "$CYAN Removing small images and renaming files... $NC"
.python/bin/python process_data.py


echo -e  "$CYAN Done!$NC" 

echo -e  "$RED IMPORTANT:$CYAN Make sure to run:$NC source .python/bin/activate$CYAN to use correct python enviroment$NC"