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

function replace_var { # param value
  sed -i.bak 's/param('"$1"') [^"]*/'"$2"'/' '_temp.svg'
}

function build_one { # svg_name
  cp $1.svg _temp.svg
  raster_svg _temp.svg "$1"-0

  cp $1.svg _temp.svg
  replace_var accent "rgb\(0,255,139\)"
  raster_svg _temp.svg "$1"-1

  cp $1.svg _temp.svg
  replace_var accent "#00bc66"
  raster_svg _temp.svg "$1"-2

  cp $1.svg _temp.svg
  replace_var iris_fill "rgb\(0,255,139\)"
  raster_svg _temp.svg "$1"-3

  cp $1.svg _temp.svg
  replace_var iris_fill "#00bc66"
  raster_svg _temp.svg "$1"-4

  cp $1.svg _temp.svg
  replace_var iris_dot "rgb\(0,255,139\)"
  raster_svg _temp.svg "$1"-5

  cp $1.svg _temp.svg
  replace_var iris_dot "#00d877"
  raster_svg _temp.svg "$1"-6

  cp $1.svg _temp.svg
  replace_var iris_dot "#00bc66"
  raster_svg _temp.svg "$1"-7

  cp $1.svg _temp.svg
  replace_var iris_fill "rgb\(0,255,139\)"
  replace_var uroboros_fill "rgb\(0,255,139\)"
  raster_svg _temp.svg "$1"-8

  cp $1.svg _temp.svg
  replace_var iris_fill "#00bc66"
  replace_var uroboros_fill "#00bc66"
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

build_one tattoo
build_one tattoo-ears
build_one tattoo-horns
build_one tattoo-ears-big
build_one tattoo-horns-big

rm _temp.svg
rm _temp.svg.bak
