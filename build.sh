#!/bin/bash

ALPHA=0
SIZE=4
OUTPUT=outs
SKIN=\#d0d0d0

function raster_svg { # in-name out-name
  svgexport $1 $OUTPUT/$2@"$SIZE"x.png "$SIZE"x
  if [ "$ALPHA" == "1" ]; then
    convert $OUTPUT/$2@"$SIZE"x.png -fuzz 15% -transparent white $OUTPUT/$2-alpha@"$SIZE"x.png
  fi
}

function replace_var { # file param value
  sed -i.bak 's/param('"$2"') [^"]*/'"$3"'/' $1
}

function build_one { # svg_name
  cp $1.svg _temp.svg
  raster_svg _temp.svg "$1"-00

  cp $1.svg _temp.svg
  replace_var _temp.svg accent "rgb\(0,255,139\)"
  raster_svg _temp.svg "$1"-10

  cp $1.svg _temp.svg
  replace_var _temp.svg accent "#00bc66"
  raster_svg _temp.svg "$1"-20

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_fill "rgb\(0,255,139\)"
  raster_svg _temp.svg "$1"-30

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_fill "#00bc66"
  raster_svg _temp.svg "$1"-40

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_fill "#00FF97"
  raster_svg _temp.svg "$1"-41

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_dot "rgb\(0,255,139\)"
  raster_svg _temp.svg "$1"-50

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_dot "#00ea81"
  raster_svg _temp.svg "$1"-60

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_dot "#00FF97"
  raster_svg _temp.svg "$1"-61

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_dot "#0B6531"
  raster_svg _temp.svg "$1"-62

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_dot "#00bc66"
  raster_svg _temp.svg "$1"-70

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_fill "rgb\(0,255,139\)"
  replace_var _temp.svg uroboros_fill "rgb\(0,255,139\)"
  raster_svg _temp.svg "$1"-80

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_fill "#00bc66"
  replace_var _temp.svg uroboros_fill "#00bc66"
  raster_svg _temp.svg "$1"-90

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_fill "#00FF97"
  replace_var _temp.svg uroboros_fill "#00FF97"
  raster_svg _temp.svg "$1"-91

}

trap ctrl_c INT

function ctrl_c() {
  mv tattoo.svg.bak tattoo.svg
  rm _temp.svg
  rm *.bak
  exit 0
}

while getopts ":ax:o:s:c" opt; do
  case $opt in
    a)
      ALPHA=1
      ;;
    x)
      SIZE=$OPTARG
      ;;
    o)
      OUTPUT=$OPTARG
      ;;
    s)
      SKIN=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    c)
      rm $OUTPUT/tattoo*.png
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

replace_var tattoo.svg skin $SKIN

cp tattoo.svg tattoo-simple.svg
replace_var tattoo-simple.svg inner "#simple-eye"
replace_var tattoo-simple.svg outer "#simple-eye-big"
build_one tattoo-simple

cp tattoo.svg tattoo-ears.svg
replace_var tattoo-ears.svg inner "#ears"
replace_var tattoo-ears.svg outer "#simple-eye-big"
build_one tattoo-ears

cp tattoo.svg tattoo-horns.svg
replace_var tattoo-horns.svg inner "#horns"
replace_var tattoo-horns.svg outer "#simple-eye-big"
build_one tattoo-horns

cp tattoo.svg tattoo-ears-big.svg
replace_var tattoo-ears-big.svg inner "#simple-eye"
replace_var tattoo-ears-big.svg outer "#ears-big"
build_one tattoo-ears-big

cp tattoo.svg tattoo-horns-big.svg
replace_var tattoo-horns-big.svg inner "#simple-eye"
replace_var tattoo-horns-big.svg outer "#horns-big"
build_one tattoo-horns-big

cp tattoo.svg tattoo-horns-big-sharper.svg
replace_var tattoo-horns-big-sharper.svg inner "#simple-eye"
replace_var tattoo-horns-big-sharper.svg outer "#horns-big-sharper"
build_one tattoo-horns-big-sharper

mv tattoo.svg.bak tattoo.svg
rm _temp.svg
rm *.bak
