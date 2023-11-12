export Fototeca=/Volumes/Teradactylo/Fototeca
export SCRIPTDIR=$HOME/proyectos/personal/jrfep.github.io
mkdir -p $SCRIPTDIR/ecos/fotos/
convert $Fototeca/Creativo/bkg-paisaje/MonticuloRedonda.JPG \
  -resize 600x600 $SCRIPTDIR/ecos/fotos/Paramo-Venezuela.png