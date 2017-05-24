#!/bin/bash

ALPHA=0
SIZE=4
OUTPUT=outs

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
  raster_svg _temp.svg "$1"-0

  cp $1.svg _temp.svg
  replace_var _temp.svg accent "rgb\(0,255,139\)"
  raster_svg _temp.svg "$1"-1

  cp $1.svg _temp.svg
  replace_var _temp.svg accent "#00bc66"
  raster_svg _temp.svg "$1"-2

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_fill "rgb\(0,255,139\)"
  raster_svg _temp.svg "$1"-3

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_fill "#00bc66"
  raster_svg _temp.svg "$1"-4

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_dot "rgb\(0,255,139\)"
  raster_svg _temp.svg "$1"-5

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_dot "#00ea81"
  raster_svg _temp.svg "$1"-6

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_dot "#00bc66"
  raster_svg _temp.svg "$1"-7

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_fill "rgb\(0,255,139\)"
  replace_var _temp.svg uroboros_fill "rgb\(0,255,139\)"
  raster_svg _temp.svg "$1"-8

  cp $1.svg _temp.svg
  replace_var _temp.svg iris_fill "#00bc66"
  replace_var _temp.svg uroboros_fill "#00bc66"
  raster_svg _temp.svg "$1"-9

}

while getopts ":ax:o:" opt; do
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
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

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

rm _temp.svg
rm *.bak
