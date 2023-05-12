#!/bin/bash
for i in {1361..1382}
do
    if [ -f "IMAG$i.jpeg" ]; 
        then
        magick IMAG$i.jpeg -format "%[exif:GPSLatitude]" info: >> data.txt
        echo \ >> data.txt
        magick IMAG$i.jpeg -format "%[exif:GPSLongitude]" info: >> data.txt
        echo \ >> data.txt
    fi
done