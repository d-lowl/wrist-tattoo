# wrist-tattoo

Several tattoo sketches written with SVG with some variables to modify templates (provided either in HTML as object params or replaced on PNG rasterising stage)

## HTML page

Clone the repository and open index.html in browser. Build script must be run at least ones beforehand. (Compatibility is not guaranteed; tested on Safari 9.1.3)

## Build script

Rasterises all svg-s with all variable options.

### Requirements

* svgexport [https://github.com/shakiba/svgexport]
* convert (ImageMagick) for alpha-versions

### Usage

./build.sh [OPTIONS]

Options:

* -a: alpha-versions
* -x: size multiplier (default is 4, corresponding to 1000px x 1000px PNG)
* -o: output directory (default is 'outs')
* -s: background color (default is 'white')
