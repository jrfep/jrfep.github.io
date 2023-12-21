# https://blog.viktomas.com/posts/making-animated-gif/

#convert Rompecabeza-mundi/*.JPG \
#    -gravity center -crop 1:1 +repage \
#    -resize 350x350 \
#    -set delay 45 \
#    animation2.gif

INPUTFOLDER=~/sandbox/imagick
OUTPUTFOLDER=lgrs/
convert $INPUTFOLDER/Rompecabeza-mundi/*.JPG \
    -gravity center \
    -resize 450x450 +repage \
    -set delay 120 $OUTPUTFOLDER/animation.gif