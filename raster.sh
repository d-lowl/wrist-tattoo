#!/bin/bash
svgexport tattoo.svg tattoo.png 10x && convert tattoo.png -fuzz 15% -transparent white tattoo-alpha.png